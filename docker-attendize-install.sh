git clone https://github.com/ryanpealer/attmod

cd attmod

sudo mkdir  attmod/public/user_content/pdf_tickets
sudo mkdir  attmod/public/user_content/organiser_images
sudo mkdir  attmod/public/user_content/event_images

sudo chmod 777 -R  attmod/public/user_content/event_images
sudo chmod 777 -R  attmod/public/user_content/organiser_images
sudo chmod 777 -R  attmod/public/user_content/pdf_tickets

sudo make setup
