# Zombie Pathfinding System

This ECS-based pathfinding system for zombies is split into three separate systems to handle async operations properly:

## Systems Overview

### 1. `targetting.luau`
- **Purpose**: Finds the closest target for each zombie
- **Frequency**: Runs every frame
- **No yielding**: Pure synchronous logic

### 2. `pathfinding.luau` 
- **Purpose**: Generates pathfinding waypoints asynchronously
- **Frequency**: Runs every 0.5 seconds (configurable)
- **Async handling**: Uses `task.spawn()` to avoid yielding in the system
- **Queue system**: Batches pathfinding requests for efficiency

### 3. `zombieMovement.luau`
- **Purpose**: Moves zombies along the generated waypoints
- **Frequency**: Runs every frame
- **No yielding**: Pure synchronous movement logic

## How It Works

1. **Target Selection**: The `targetting` system finds the closest target for each zombie and stores it in the `Zombie` component
2. **Path Generation**: The `pathfinding` system queues zombies that need paths and processes them asynchronously using `PathfindingService`
3. **Movement**: The `zombieMovement` system follows the generated waypoints, handling jumping and waypoint progression

## Component Fields

The `Zombie` component now includes:
- `target`: Vector3 position of the closest target
- `waypoints`: Array of pathfinding waypoints
- `currentWaypointIndex`: Current waypoint being followed

## Benefits

- **No yielding in systems**: All async operations are handled outside the main ECS loop
- **Efficient**: Pathfinding only runs when needed (every 0.5s) instead of every frame
- **Scalable**: Queue system prevents overwhelming the PathfindingService
- **Modular**: Each system has a single responsibility

## Configuration

You can adjust the pathfinding frequency by changing `pathfindingCooldown` in `pathfinding.luau`. 