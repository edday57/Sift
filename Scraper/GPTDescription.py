import openai
import json

# Set up OpenAI API key
openai.api_key = "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"
property_description = "A one bedroom luxury apartment located within the impressive Argo House development. This 2nd floor apartment includes an inviting living space, fitted kitchen with integrated appliances, fitted bedroom storage and a private terrace. Residents will also have access to a concierge service. The development is located near Maida Vale Underground station providing a valuable transport link for commutes across the Capital.Deposit: Equivalent to 5 weeks’ rentCouncil: Brent London, Band BClient Money Protection (CMP) provided by: UKALAThe Property Ombudsman Scheme, Membership No: T02100"
# Set up prompt for the property description
prompt = (f"Please rewrite the following property description, wording it more nicely and making it sound more appealing. Format it with lines where appropriate:\n\n"
          f"Property description: {property_description}")

# Set up OpenAI API parameters
model_engine = "text-davinci-003"
temperature = 0.5
max_tokens = 1000

# Send request to OpenAI API
response = openai.Completion.create(
    engine=model_engine,
    prompt=prompt,
    temperature=temperature,
    max_tokens=max_tokens
)

# Get the rephrased property description from the API response
rephrased_description = response.choices[0].text.strip()

# Display the rephrased description
with open("desc.txt", "a") as f:
                f.write(str(rephrased_description))
                f.write("\n")
print(f"Rephrased description: {rephrased_description}")

# Use the rephrased description in your mobile app as needed