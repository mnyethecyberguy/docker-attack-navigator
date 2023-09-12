# MITRE ATT&CK® Navigator

Dockerfile for [MITRE ATT&CK® Navigator](https://github.com/mitre-attack/attack-navigator). 

It builds a static version of the Navigator site on nginx.  Current version is v4.8.2.

## Using the Image

You can build the image yourself using this Dockerfile or pull from Docker Hub:

```
docker pull mnyethecyberguy/mitre-attack-navigator:v4.8.2
```

Map port 80 from host to container when running the image.

```
docker run -p 80:80 mitre-attack-navigator
```