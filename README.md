# NPMprune

`npmprune.sh` is a small script to prune unnecessary files from `./node_modules`, such as Markdown.

By default, it doesn't remove TypeScript definitions.  
On production, use the `-p` to also remove them.

**Install as a command:**

```dockerfile
wget -O npmprune https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh && chmod +x npmprune
```

**On deployment:**

```sh
wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -- -p
```

**In a Dockerfile:**

```dockerfile
RUN wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmprune.sh | sh -s -- -p
```
