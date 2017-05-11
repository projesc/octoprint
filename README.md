# ESC GPIO Scripts

Scripts to emit events on start and stop of octoprint jobs.

Just copy the files at you configured dir or clone the repo:

    $ git clone https://github.com/projesc/octoprint files/scripts/octoprint

## Events

```json
{"name":"octo_printing_started","payload":"full_json_job"}
{"name":"octo_printing_stopped","payload":"full_json_job"}
```

## License

MIT

