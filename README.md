# esa-export-v1-viewer

# Usage

1. Download exported zip
2. Unarchive zip and rename folder to `exported_files` on current directory
  ```
  exported_files
    ├── foo_category
    │   └── title.md
    ├── README.md
    ...
  ```
3. `docker run --rm -it -p 4567:4567 -v $PWD/exported_files:/app/exported_files fukayatsu/esa-export-v1-viewer:0.0.1`
4. Open http://localhost:4567 on browser


# Development

- `docker build -t esa-export-v1-viewer .`
- `docker tag esa-export-v1-viewer fukayatsu/esa-export-v1-viewer:0.0.1`
- `docker push fukayatsu/esa-export-v1-viewer:0.0.1`
