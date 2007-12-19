From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [patch 1/3] Add generic routine for parsing map-like options
	on kernel cmd-line
Date: Wed, 19 Dec 2007 09:00:13 -0800
Message-ID: <1198083613.32480.53.camel@sven.thebigcorporation.com>
References: <20071218220505.828395321@bohmer.net> >
	  <4768450f.1636440a.6de8.596a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	Darren Hart <dvhltc@us.ibm.com>,
	linux-rt-users@vger.kernel.org, Remy Bohmer <linux@bohmer.net>
To: Remy Bohmer <remy@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:60948 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752579AbXLSRA0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2007 12:00:26 -0500
In-Reply-To: <4768450f.1636440a.6de8.596a@mx.google.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 2007-12-18 at 23:05 +0100, Remy Bohmer wrote:
> plain text document attachment
> (add-map-functionality-to-kernel-cmdline.patch)
> This patch adds a generic routine to the kernel, so that a map of
> settings can be entered on the kernel commandline.
> 

Hi Remy,

this might be of general interest - you should consider copying LKML for
feedback.

Regards,

Sven

> Signed-off-by: Remy Bohmer <linux@bohmer.net>
> 
> ---
> ---
>  include/linux/kernel.h |    1 
>  lib/cmdline.c          |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> Index: linux-2.6.24-rc5-rt1/include/linux/kernel.h
> ===================================================================
> --- linux-2.6.24-rc5-rt1.orig/include/linux/kernel.h	2007-12-18 21:32:09.000000000 +0100
> +++ linux-2.6.24-rc5-rt1/include/linux/kernel.h	2007-12-18 21:33:58.000000000 +0100
> @@ -164,6 +164,7 @@ extern int vsscanf(const char *, const c
>  
>  extern int get_option(char **str, int *pint);
>  extern char *get_options(const char *str, int nints, int *ints);
> +extern int get_map_option(const char *str, const char *key, int *pint);
>  extern unsigned long long memparse(char *ptr, char **retptr);
>  
>  extern int core_kernel_text(unsigned long addr);
> Index: linux-2.6.24-rc5-rt1/lib/cmdline.c
> ===================================================================
> --- linux-2.6.24-rc5-rt1.orig/lib/cmdline.c	2007-10-09 22:31:38.000000000 +0200
> +++ linux-2.6.24-rc5-rt1/lib/cmdline.c	2007-12-18 21:33:58.000000000 +0100
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> +#include <asm/setup.h>
>  
>  /*
>   *	If a hyphen was found in get_option, this will handle the
> @@ -114,6 +115,63 @@ char *get_options(const char *str, int n
>  }
>  
>  /**
> + *	get_map_option - Parse integer from an option map
> + *
> + *	This function parses an integer from an option map like
> + *           some_map=key1:99,key2:98,...,keyN:NN,NN
> + *	Only the value of the first match is returned, or if no
> + *	key option is given (key = NULL) the value of the first
> + *	field without a ':' is returned.
> + *
> + *	@str: option string
> + *	@key: The key inside the map, can be NULL
> + *	@pint: (output) integer value parsed from the map @str
> + *
> + *	Return values:
> + *	0 - no int in string
> + *	1 - int found
> + */
> +int get_map_option(const char *str, const char *key, int *pint)
> +{
> +	char  buf[COMMAND_LINE_SIZE];
> +	char  *p, *substr;
> +	int   found = 0;
> +
> +	/* We must copy the string to the stack, because strsep()
> +	   changes it.*/
> +	strncpy(buf, str, COMMAND_LINE_SIZE);
> +	buf[COMMAND_LINE_SIZE-1] = '\0';
> +
> +	p = buf;
> +	substr = strsep(&p, ",");
> +	while ((!found) && (substr != NULL)) {
> +		if (strlen(substr) != 0) {
> +			if (key == NULL) {
> +				/* Check for the absence of any ':' */
> +				if (strchr(substr, ':') == NULL) {
> +					sscanf(substr, "%d", pint);
> +					found = 1;
> +				}
> +			} else {
> +				/* check if the first part of the key matches */
> +				if (!strncmp(substr, key, strlen(key))) {
> +					substr += strlen(key);
> +					/* Now the next char must be a ':',
> +					   if not, search for the next match */
> +					if (*substr == ':') {
> +						substr++;
> +						sscanf(substr, "%d", pint);
> +						found = 1;
> +					}
> +				}
> +			}
> +		}
> +		substr = strsep(&p, ",");
> +	}
> +	return found;
> +}
> +
> +/**
>   *	memparse - parse a string with mem suffixes into a number
>   *	@ptr: Where parse begins
>   *	@retptr: (output) Pointer to next char after parse completes
> 
