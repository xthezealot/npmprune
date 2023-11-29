# NPMprune

`npmprune.sh` is a small script to prune unnecessary files from `./node_modules`, such as Markdown.

By default, it doesn't remove TypeScript definitions.  
On production, use the `-p` to also remove them.

**During development:**

```sh
wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmrune.sh | sh
```

**On deployment:**

```sh
wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmrune.sh | sh -- -p
```

**In a Dockerfile:**

```dockerfile
RUN wget -qO- https://raw.githubusercontent.com/xthezealot/npmprune/master/npmrune.sh | sh -s -- -p
```
