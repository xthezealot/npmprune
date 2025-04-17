<p align="center"><img src="https://i.imgur.com/joBUSud.jpg" width="256" height="192"></p>

# npmprune

`npmprune.sh` is an lightweight script designed to clean up your `node_modules` directory by removing unnecessary files like Markdown, doc and config files.

It helps in reducing the overall size of `node_modules`, optimizing storage space, and speeding up deployments, especially in containerized environments.

By detecting `NODE_ENV`, it can perform a more aggressive cleanup, tailored for production builds such as in Docker containers.

1. [Install](#install)
2. [Usage](#usage)
3. [Integration](#integration)
   - [In deployment scripts](#in-deployment-scripts)
   - [In a Dockerfile](#in-a-dockerfile)
4. [Compatibility](#compatibility)

## Install

```sh
wget -O /usr/local/bin/npmprune https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh && chmod +x /usr/local/bin/npmprune
```

## Usage

```sh
npmprune
```

### Production mode

If the `NODE_ENV` environment variable is set to `production`, NPMprune performs a more extensive cleanup by also removing type definitions.

### Additional Patterns

You can provide additional patterns by passing them as arguments:

```sh
npmprune "*.log" "*.bak"
```

## Integration

### In deployment scripts

```sh
# Basic usage:
wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh

# With additional patterns:
wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -s -- "*.log" "*.bak"
```

### In a Dockerfile

```dockerfile
# Basic usage:
RUN wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh

# With additional patterns:
RUN wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -s -- "*.log" "*.bak"
```

## Compatibility

npmprune is compatible with both Linux and macOS environments, even with the most basic Alpine Linux setup.
