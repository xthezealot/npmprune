# NPMprune

`npmprune.sh` is an lightweight script designed to clean up your `node_modules` directory by removing unnecessary files like doc, Markdown, and config files.

It helps in reducing the overall size of `node_modules`, optimizing storage space, and speeding up deployments, especially in containerized environments.

It includes a `-p` flag to perform a more aggressive cleanup, tailored for production builds such as in Docker containers.

1. [Install](#install)
2. [Usage](#usage)
   - [Production mode](#production-mode)
3. [Integration](#integration)
   - [In deployment scripts](#in-deployment-scripts)
   - [In a Dockerfile](#in-a-dockerfile)
4. [Compatibility](#compatibility)

## Install

```sh
wget -O npmprune https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh && chmod +x npmprune
```

## Usage

```sh
npmprune
```

### Production mode

For production environments, use the `-p` flag to perform a more extensive cleanup:

```sh
npmprune -p
```

## Integration

### In deployment scripts

```sh
wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -- -p
```

### In a Dockerfile

```dockerfile
RUN wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -s -- -p
```

# Compatibility

NPMprune is compatible with both Linux and macOS environments, even with the most basic Alpine Linux setup.
