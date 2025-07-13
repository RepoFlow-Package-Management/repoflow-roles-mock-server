# Mock Roles API Example for RepoFlow

This project is a **minimal, ready-to-use example of a simple “roles server”** to demonstrate how you can provide user role and permission information to RepoFlow via a custom API.

It uses an unprivileged Nginx Docker container to serve static JSON files that describe user permissions, and can enforce an authentication token via HTTP header. This is useful as a reference implementation or for testing RepoFlow’s external role mapping feature.

## Features

- **Static roles API**: Returns user permissions as JSON for each user (by email)
- **Header-based auth**: Requires a custom header (like `X-Auth-Token`) for all requests
- **Easy to deploy**: Just build and run with Docker
- **Customizable**: Add or modify user files as needed

## How it Works

- Each user’s roles and permissions are defined in a `.json` file named after their email address (e.g., `alice@example.com.json`).
- RepoFlow fetches roles for a user by making a GET request to the endpoint, with the email filled in where `:user-email` appears in the URL, sending an authentication header.
- Nginx serves the static file if the auth header matches.

## Example

To fetch roles for `alice@example.com`:

```bash
curl -H "X-Auth-Token: SECRET123" http://localhost:9085/roles/alice@example.com
```

returns

```JSON
{
  "workspaces": [
    {
      "name": "team-1-workspace",
      "workspacePermission": "admin"
    },
    {
      "name": "team-2-workspace",
      "workspacePermission": "none",
      "repositories": [
        { "name": "repo-1", "permission": "canDeploy" },
        { "name": "repo-2", "permission": "canRead" },
        { "name": "repo-3", "permission": "canDeleteOverride" }
      ]
    }
  ]
}
```

## How to Run

You can run this roles API server either with the provided `run.sh` script or manually using Docker commands.

### Option 1: Using `run.sh`

Just run:

```bash
./run.sh
```

### Option 2: Manual Docker Commands

```bash
docker build -t repoflow-mock-roles-api .
docker run -p 9085:9085 \
  -v $(pwd)/roles:/usr/share/nginx/html/roles \
  repoflow-mock-roles-api
```

### Learn More

See the [RepoFlow documentation on Role Mapping]() for more details about role mapping, schemas, and best practices.

### License

This mock roles API project is licensed under the MIT License.  
**Note:** RepoFlow itself is not MIT-licensed, this repository is only an example and reference for integrating with RepoFlow.
