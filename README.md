# WordPress toolkit

[![Packagist Version](https://img.shields.io/github/v/release/studiometa/wp-toolkit?include_prereleases&label=packagist&style=flat-square)](https://packagist.org/packages/studiometa/wp-toolkit)
[![License MIT](https://img.shields.io/packagist/l/studiometa/wp-toolkit?style=flat-square)](https://github.com/studiometa/wp-toolkit/blob/master/LICENSE)
[![Codecov](https://img.shields.io/codecov/c/github/studiometa/wp-toolkit?style=flat-square)](https://codecov.io/gh/studiometa/wp-toolkit/)

> A PHP toolkit to boost your WordPress development! 🚀

## Installation

Install the package via Composer: 

```bash
composer require studiometa/wp-toolkit
```

## Usage

```php
use Studiometa\WPToolkit\Assets;
use Studiometa\WPToolkit\Cleanup;
use Studiometa\WPToolkit\Builders\PostTypeBuilder;

// Load assets from `assets.yaml` configuration
new Assets( get_template_directory() );

// Clean WordPress
new Cleanup();

// Create Custom Post Type
$cpt = new PostTypeBuilder( 'product' );
$cpt->set_labels( 'Product', 'Products' )
  ->set_has_archive( true )
  ->register();

// Create Custom Taxonomy
$tax = new TaxonomyBuilder( 'product-cat' );
$tax->set_post_types( 'product' )
  ->set_labels( 'Product Category', 'Product Categories' )
  ->register();
```

## Transient Cleaner
### Usage
> **Important** Transients keys must be prefixed with transient cleaner prefix (`TransientCleaner::PREFIX`) to be tracked.

```php
use Studiometa\WPToolkit\TransientCleaner;

// 1. Set a transient with transient cleaner prefix.
if ( $my_condition ) {
  set_transient(
    TransientCleaner::PREFIX . 'transient_key',
    'example'
  );
}

// 2. Initialize transient cleaner.
$transient_cleaner = TransientCleaner::get_instance(
  array(
    'post'   => array(
      'all'           => array(
        TransientCleaner::PREFIX . 'transient_key',
      ),
      'post_type_key' => array(
        TransientCleaner::PREFIX . 'transient_key',
        TransientCleaner::PREFIX . 'transient_key_1',
      )
    ),
    'term'   => array(
      'all'                    => array(),
      'your_taxonomy_type_key' => array(),
      'category'               => array(),
    ),
    'option' => array(
      'all'             => array(),
      'option_key'      => array(),
      'blogdescription' => array(),
    ),
  )
);

// Update config if needed.
$transient_cleaner->set_config(array());

// 3. Insert/Update post/term/option to see your transients deleted based on your config.
``` 
