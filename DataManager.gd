extends Node

# Storage path for the data
var save_path = "user://save_data.cfg"

# Datenstruktur zum Speichern und Laden
var player_data = {
    "high_score": 0,
    "player_name": "Player"
}

# Function to save the data
func save_data():
    var file = FileAccess.open(save_path, FileAccess.WRITE)
    if file:
        file.store_var(player_data)
        file.close()
        print("Daten gespeichert")
    else:
        print("Fehler beim Speichern der Daten")

# Data loading function
func load_data():
    if FileAccess.file_exists(save_path):
        var file = FileAccess.open(save_path, FileAccess.READ)
        if file:
            player_data = file.get_var()
            file.close()
            print("Daten geladen: ", player_data)
        else:
            print("Fehler beim Laden der Daten")
    else:
        print("Keine gespeicherten Daten gefunden")

# Function for setting a single data value
func set_data(key: String, value):
    player_data[key] = value
    save_data()

# Function to load a single data value
func get_data(key: String):
    if player_data.has(key):
        return player_data[key]
    else:
        return null

# Example calls for saving and loading the data
func _ready():
    load_data()
