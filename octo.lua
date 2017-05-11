
local http = require("http")
local json = require("json")

local isPrinting=false
local prevJob=nil

local api = "http://"..config("octoaddr").."/api"
local key = config("octokey")


if key ~= nil and #key > 1 then
  tick(2,function()
    local currPrinting=false
    local currJob=nil
    res,err = http.request("GET",api.."/job",{
      headers={
        ["X-Api-Key"]=key
      }
    })
    if err ~= nil then
      log(err)
    else
      if res.body ~= nil then
        local job = json.decode(res.body)
        if job.state ~= nil then
          if job.state == "Printing" then
            currPrinting=true
            currJob=job
          end
        end
      end
    end

    if isPrinting and not currPrinting then
      sendEvent("octo_printing_started",json.encode(currJob))
    end

    if not isPrinting and currPrinting then
      sendEvent("octo_printing_stopped",json.encode(prevJob))
    end

    isPrinting = currPrinting
    prevJob=currJob
    return true
  end)
end
