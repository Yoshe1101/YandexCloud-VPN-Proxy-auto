from jinja2 import Template
import yaml

# Load config variables
with open('config.yml', 'r') as file:
    config = yaml.safe_load(file)


# terraform
with open('./terraform/templates/provider.tf_template', 'r') as file:
    template = Template(file.read())

# Render the template with config values
output = template.render(config)

# Write the rendered output to the file
with open('./terraform/provider.tf', 'w') as file:
    file.write(output)


# yandex_prov
with open('./terraform/templates/yandex_prov.sh_template', 'r') as file:
    template = Template(file.read())

# Render the template with config values
output = template.render(config)

# Write the rendered output to the file
with open('./terraform/yandex_prov.sh', 'w') as file:
    file.write(output)


# docker env
with open('./terraform/templates/.env_template', 'r') as file:
    template = Template(file.read())

# Render the template with config values
output = template.render(config)

# Write the rendered output to the file
with open('./terraform/files/.env', 'w') as file:
    file.write(output)


# terraform vars
with open('./terraform/templates/terraform.tfvars_template', 'r') as file:
    template = Template(file.read())

# Render the template with config values
output = template.render(config)

# Write the rendered output to the file
with open('./terraform/terraform.tfvars', 'w') as file:
    file.write(output)

