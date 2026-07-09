Since you're using **Ubuntu 24.04**, here's the complete setup to get your Laravel Bootcamp project running from scratch.

---

# 1. Update the system

```bash
sudo apt update && sudo apt upgrade -y
```

---

# 2. Install PHP 8.3 and required extensions

```bash
sudo apt install -y \
php8.3 \
php8.3-cli \
php8.3-common \
php8.3-mysql \
php8.3-sqlite3 \
php8.3-mbstring \
php8.3-xml \
php8.3-curl \
php8.3-zip \
php8.3-bcmath \
php8.3-intl \
unzip \
curl \
git
```

Verify:

```bash
php -v
```

---

# 3. Install Composer

```bash
cd ~

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

php composer-setup.php

sudo mv composer.phar /usr/local/bin/composer

rm composer-setup.php

composer --version
```

---

# 4. Install Laravel Installer (Optional)

```bash
composer global require laravel/installer
```

Add it to PATH:

```bash
echo 'export PATH="$HOME/.config/composer/vendor/bin:$HOME/.composer/vendor/bin:$PATH"' >> ~/.bashrc

source ~/.bashrc
```

Verify:

```bash
laravel -v
```

---

# 5. Install Node.js 22 (Required for Laravel 12 + Vite)

Remove the old Node.js:

```bash
sudo apt remove nodejs -y
```

Install Node.js 22:

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

sudo apt install -y nodejs
```

Verify:

```bash
node -v
npm -v
```

Expected:

```text
v22.x.x
10.x.x
```

---

# 6. Clone the project

If not already cloned:

```bash
cd ~/Python-learning

git clone https://github.com/laravel/bootcamp.git
```

Move into the project:

```bash
cd ~/Python-learning/bootcamp
```

---

# 7. Install PHP dependencies

```bash
composer install
```

---

# 8. Install JavaScript dependencies

```bash
npm install
```

---

# 9. Configure environment

Copy the environment file:

```bash
cp .env.example .env
```

Generate the application key:

```bash
php artisan key:generate
```

---

# 10. Configure SQLite (Laravel Bootcamp default)

Create the SQLite database:

```bash
touch database/database.sqlite
```

Open `.env`:

```bash
nano .env
```

Update these lines:

```env
DB_CONNECTION=sqlite
# Remove or comment out:
# DB_HOST=
# DB_PORT=
# DB_DATABASE=
# DB_USERNAME=
# DB_PASSWORD=
```

Save with:

* `Ctrl + O`, Enter
* `Ctrl + X`

---

# 11. Run database migrations

```bash
php artisan migrate
```

If prompted:

```text
Would you like to create it? (yes/no)
```

Type:

```text
yes
```

---

# 12. Start the Vite development server

```bash
npm run dev
```

Keep this terminal open.

---

# 13. Start the Laravel development server

Open a **new terminal**:

```bash
cd ~/Python-learning/bootcamp

php artisan serve
```

You should see something like:

```text
INFO  Server running on:

http://127.0.0.1:8000
```

---

# 14. Open the application

Visit:

```
http://127.0.0.1:8000
```

---

## If you encounter the Node.js 18 issue again

Run:

```bash
node -v
```

If it still shows:

```text
v18.x.x
```

then Node.js 22 was not installed correctly. Before proceeding further, share the output of:

```bash
node -v
npm -v
which node
apt-cache policy nodejs
```

and I'll help you resolve the version issue.

# Docker setup 

### Build the image
Run:

```bash
docker build -t laravel-bootcamp .
```
### Run the container

Run:

```bash
docker run -itd -p 8000:8000 laravel-bootcamp
```

### Then open:
```bash
http://localhost:8000
```

                       ###############################
