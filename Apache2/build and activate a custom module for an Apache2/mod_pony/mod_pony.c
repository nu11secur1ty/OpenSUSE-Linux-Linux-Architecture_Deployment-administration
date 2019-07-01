/* To install:
 *
 * apxs -cia mod_pony.c
 *
 * Note that apxs might be called something else on your system if you
 * are Debian-encumbered.
 * 
 * Configure with:
 *
 * LoadModule pony_module        modules/mod_pony.so
 * <Location /pony>
 *   SetHandler pony
 * </Location>
 *
 * You can apparently configure this in a .htaccess file (not sure why
 * you'd want to) by creating a file named pony (it's fine if it's
 * empty) then putting this in your .htaccess file:
 *
 * <Files pony>
 * SetHandler pony
 * </Files>
 *
 * This module is licensed under the HJTI license 
 * (http://drbacchus.com/hjti) which is 100% compatible with 
 * the Apache Software License.
 *
 * More details about the reasons for this inanity here:
 * http://drbacchus.com/mod_pony
 *
 */

#include <httpd.h>
#include <http_protocol.h>
#include <http_config.h>
#include <http_log.h>
#include <stdlib.h>

typedef struct {
    int ponyprob;
} pony_config_rec;

module AP_MODULE_DECLARE_DATA pony_module;

static int pony_handler(request_rec* r) {
    int ponyrand = (int) (rand());
    pony_config_rec *conf = ap_get_module_config(r->per_dir_config,
                                                       &pony_module);
    if ( !r->handler || strcmp(r->handler, "pony") ) {
        return DECLINED ;
    }
    if ( r->method_number != M_GET ) {
        return HTTP_METHOD_NOT_ALLOWED ;
    }
    ap_set_content_type(r, "text/html;charset=ascii") ;
    if (ponyrand < (conf->ponyprob))
    {
    	ap_rputs("<html><head><title>No pony!</title></head>\n", r);
    	ap_rputs("<body><pre>\n", r);
ap_rputs("             _                                \n", r);
ap_rputs(" _ __   ___ | |_   _   _  ___  _   _ _ __ ___ \n", r);
ap_rputs("| '_ | / _ || __| | | | |/ _ || | | | '__/ __|\n", r);
ap_rputs("| | | | (_) | |_  | |_| | (_) | |_| | |  |__ |\n", r);
ap_rputs("|_| |_||___/ |__|  |__, ||___/ |__,_|_|  |___/\n", r);
ap_rputs("                   |___/                      \n", r);
    	ap_rputs("</pre></body></html>\n", r);

    }else{
    	ap_rputs("<html><head><title>Pony!</title></head>\n", r);
    	ap_rputs("<body><pre>\n", r);


ap_rputs("  ,  ,.~\"\"\"\"\"~~..                                           ___\n", r);
ap_rputs("  )\\,)\\`-,       `~._                                     .'   ``._\n", r);
ap_rputs("  \\  \\ | )           `~._                   .-\"\"\"\"\"-._   /         \n", r);
ap_rputs(" _/ ('  ( _(\\            `~~,__________..-\"'          `-<           \\\n", r);
ap_rputs(" )   )   `   )/)   )        \\                            \\           |\n", r);
ap_rputs("') /)`      \\` \\,-')/\\      (                             \\          |\n", r);
ap_rputs("(_(\\ /7      |.   /'  )'  _(`                              |         |\n", r);
ap_rputs("    \\\\      (  `.     ')_/`                                |         /\n", r);
ap_rputs("     \\       \\   \\                                         |        (\n", r);
ap_rputs("      \\ )  /\\/   /                                         |         `~._\n", r);
ap_rputs("       `-._)     |                                        /.            `~,\n", r);
ap_rputs("                 |                          |           .'  `~.          (`\n", r);
ap_rputs("                  \\                       _,\\          /       \\        (``\n", r);
ap_rputs("                   `/      /       __..-i\"   \\         |        \\      (``\n", r);
ap_rputs("                  .'     _/`-..--\"\"      `.   `.        \\        ) _.~<``\n", r);
ap_rputs("                .'    _.j     /            `-.  `.       \\      '=< `\n", r);
ap_rputs("              .'   _.'   \\    |               `.  `.      \\\n", r);
ap_rputs("             |   .'       ;   ;               .'  .'`.     \\\n", r);
ap_rputs("             \\_  `.       |   \\             .'  .'   /    .'\n", r);
ap_rputs("               `.  `-, __ \\   /           .'  .'     |   (\n", r);
ap_rputs("                 `.  `'` \\|  |           /  .-`     /   .'\n", r);
ap_rputs("                   `-._.--t  ;          |_.-)      /  .'\n", r);
ap_rputs("                          ; /           \\  /      / .'\n", r);
ap_rputs("                         / /             `'     .' /\n", r);
ap_rputs("                        /,_\\                  .',_(\n", r);
ap_rputs("                       /___(                 /___( \n", r);

    	ap_rputs("</pre></body></html>\n", r);
    }
    return OK ;
}

static int pony_init_handler(apr_pool_t *p, apr_pool_t *plog, apr_pool_t *ptemp,
                             server_rec *s)
{
    ap_add_version_component(p, "PONY!");

    return OK;
}

static void pony_hooks(apr_pool_t* pool) {
    ap_hook_handler(pony_handler, NULL, NULL, APR_HOOK_MIDDLE);
    ap_hook_post_config(pony_init_handler, NULL, NULL, APR_HOOK_MIDDLE);
}

static void *create_pony_dir_config(apr_pool_t *p, char *d)
{
    pony_config_rec *conf = apr_palloc(p, sizeof(*conf));

    conf->ponyprob = (int) RAND_MAX / 2;
    return conf;
}

module AP_MODULE_DECLARE_DATA pony_module = {
        STANDARD20_MODULE_STUFF,
        create_pony_dir_config,
        NULL,
        NULL,
        NULL,
        NULL,
        pony_hooks
};

