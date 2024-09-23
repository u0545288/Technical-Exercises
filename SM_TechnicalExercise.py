# Import the request library to allow HTTP requests to the API
import requests

def main():
    url = "https://swapi.dev/api/people/"
    female_characters = [] # Empty list to store characters

    while url: # Loop continues as long as URL is available and evaluating to to true
        data = requests.get(url).json() # parse as JSON
        # Filter list to only include female characters
        female_characters.extend([char for char in data['results'] if char['gender'] == 'female'])
        # Updates URL to the next page of results. URL is none if there are no more pages, ending loop
        url = data['next']

    # Creates file
    with open("female_characters.txt", "w", encoding = 'utf-8', errors='replace') as file:
        file.write("Row Number, Character Name, ID Number, Eye Color\n") # Header row
        # Iterate through female characters. Start row numbers at "1"
        for row, char in enumerate(female_characters, start=1):
            # Use f-string: NOTE: use URL to retrieve character ID
            file.write(f"{row}, {char['name']}, {char['url'].split('/')[-2]}, {char['eye_color']}\n")

# Script runs directly, set name to "main". Script imported as module = set name to name of script
# Allows Python to use this as a module or a standalone script
if __name__ == "__main__":
    main()
