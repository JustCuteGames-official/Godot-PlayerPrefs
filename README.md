# Godot-PlayerPrefs
This program is designed to manage persistent data storage for a Godot 4.2 game, similar to the PlayerPrefs system in Unity. It leverages the FileAccess class to read and write data to a configuration file located in the user directory. This ensures that data is saved across sessions and can be accessed globally from any script within the project.

# DataManager.gd

This script acts as a global data manager, enabling the storage, retrieval, and manipulation of game data. It is configured to be a Singleton (autoload) in Godot, allowing global access.

## Global Variables

### `save_path`
- **Type:** `String`
- **Description:** Defines the file path where the data will be saved. The `user://` prefix indicates that the file is stored in the user directory specific to the application.
- **Value:** `"user://save_data.cfg"`

### `player_data`
- **Type:** `Dictionary`
- **Description:** A dictionary that holds the game data to be saved and loaded. This initial example includes `high_score` and `player_name` but can be extended to include other data as needed.
- **Default Value:**
    ```gdscript
    {
        "high_score": 0,
        "player_name": "Player"
    }
    ```

## Functions

### `save_data()`
- **Description:** Saves the current state of `player_data` to the specified file path.
- **Process:**
  1. Opens the file at `save_path` in write mode using `FileAccess.open()`.
  2. Checks if the file was successfully opened.
  3. If successful, writes the `player_data` dictionary to the file using `file.store_var()`.
  4. Closes the file.
  5. Prints "Data saved" to the console.
  6. If the file opening fails, prints "Error saving data" to the console.
- **Code:**
    ```gdscript
    func save_data():
        print("Saving data to: ", save_path)
        var file = FileAccess.open(save_path, FileAccess.WRITE)
        if file:
            file.store_var(player_data)
            file.close()
            print("Data saved")
        else:
            print("Error saving data")
    ```

### `load_data()`
- **Description:** Loads the game data from the specified file path into `player_data`.
- **Process:**
  1. Checks if the file exists at `save_path` using `FileAccess.file_exists()`.
  2. If the file exists, opens the file in read mode.
  3. Checks if the file was successfully opened.
  4. If successful, reads the data into the `player_data` dictionary using `file.get_var()`.
  5. Closes the file.
  6. Prints "Data loaded" along with the loaded data to the console.
  7. If the file opening fails, prints "Error loading data" to the console.
  8. If the file does not exist, prints "No saved data found" to the console.
- **Code:**
    ```gdscript
    func load_data():
        if FileAccess.file_exists(save_path):
            var file = FileAccess.open(save_path, FileAccess.READ)
            if file:
                player_data = file.get_var()
                file.close()
                print("Data loaded: ", player_data)
            else:
                print("Error loading data")
        else:
            print("No saved data found")
    ```

### `set_data(key: String, value)`
- **Description:** Sets a specific value in the `player_data` dictionary and saves the updated data to the file.
- **Parameters:**
  - `key`: The key for the data entry (must be a string).
  - `value`: The value to be set for the specified key.
- **Process:**
  1. Updates the `player_data` dictionary with the provided key-value pair.
  2. Calls `save_data()` to persist the updated data.
- **Code:**
    ```gdscript
    func set_data(key: String, value):
        player_data[key] = value
        save_data()
    ```

### `get_data(key: String)`
- **Description:** Retrieves a specific value from the `player_data` dictionary.
- **Parameters:** `key`: The key for the data entry (must be a string).
- **Returns:** The value associated with the key if it exists, otherwise returns `null`.
- **Process:**
  1. Checks if the key exists in the `player_data` dictionary using the `has` method.
  2. If the key exists, returns the corresponding value.
  3. If the key does not exist, returns `null`.
- **Code:**
    ```gdscript
    func get_data(key: String):
        if player_data.has(key):
            return player_data[key]
        else:
            return null
    ```

### `_ready()`
- **Description:** This is a built-in Godot function that runs when the node is added to the scene. It initializes the data by loading it from the file.
- **Process:**
  1. Calls `load_data()` to populate `player_data` with any existing saved data.
- **Code:**
    ```gdscript
    func _ready():
        load_data()
    ```

## Example Usage

Once the `DataManager` is set up as an autoload singleton, you can easily access and manipulate game data from any other script in your project.

### Setting a Data Value:
```gdscript
DataManager.set_data("high_score", 42)
 ```

### Getting a Data Value:
```gdscript
var high_score = DataManager.get_data("high_score")
print(high_score)  # Output: 42
 ```

Updating the High Score:
 ```gdscript
func update_high_score(new_score):
    var current_high_score = DataManager.get_data("high_score")
    if new_score > current_high_score:
        DataManager.set_data("high_score", new_score)
 ```

### Adding DataManager as a Singleton
Open the Project Settings:
Go to Project > Project Settings... > AutoLoad.
Add DataManager.gd:
Add the DataManager.gd script file.
Set the Node Name to DataManager.
This setup ensures that DataManager is loaded automatically when the project starts, making its functions accessible from any script without needing to create instances manually.

### Debugging
The script includes print statements to help with debugging. These statements provide feedback in the console regarding the status of data saving and loading operations. If the file is not being created or data is not being loaded, the print statements can help identify where the process is failing.
