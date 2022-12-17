# jupyter lab

```sh
docker run \
  -p 1234:1234 \
  --mount type=bind,source="$(pwd)",target=/jupyter \
  --entrypoint jupyter-lab \
  ghcr.io/wckdouglas/bio-tools/single_cell:latest \
  --allow-root \
  --ip 0.0.0.0 \
  --port 1234 
```
