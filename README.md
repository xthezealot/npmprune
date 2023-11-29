# NPMprune

`npmprune.sh` is an lightweight script designed to clean up your `node_modules` directory by removing unnecessary files like doc, Markdown, and config files.

It helps in reducing the overall size of `node_modules`, optimizing storage space, and speeding up deployments, especially in containerized environments.

It includes a `-p` flag to perform a more aggressive cleanup, tailored for production builds such as in Docker containers.

1. [Installation](#installation)
2. [Usage](#usage)
   - [Default](#default)
   - [Production Mode Usage](#production-mode)
3. [Integration in deployment scripts](#integration-in-deployment-scripts)
4. [Integration in a Dockerfile](#integration-in-a-dockerfile)
5. [Compatibility](#compatibility)

## Installation

Make `npmprune.sh` available as a command:

```sh
wget -O npmprune https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh && chmod +x npmprune
```

## Usage

### Default

For a standard cleanup:

```sh
npmprune
```

### Production mode

For production environments, such as in a Docker container, use the `-p` flag to perform a more extensive cleanup:

```sh
npmprune -p
```

## Integration in deployment scripts

```sh
wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -- -p
```

## Integration in a Dockerfile

Incorporate NPMprune in your Dockerfile for optimized container builds:

```dockerfile
RUN wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -s -- -p
```

# Compatibility

NPMprune is compatible with both Linux and macOS environments, even with the most basic Alpine Linux setup.
