From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [patch 1/3] Add generic routine for parsing map-like options on
 kernel cmd-line (repost:CC to LKML)
Date: Wed, 19 Dec 2007 13:00:59 -0800
Message-ID: <20071219130059.d99489d1.randy.dunlap@oracle.com>
References: <20071219194551.315868746@bohmer.net>
	<4769787e.01b4420a.2b28.ffff88cf@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	Darren Hart <dvhltc@us.ibm.com>,
	linux-rt-users@vger.kernel.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:11689 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbXLSVJk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2007 16:09:40 -0500
In-Reply-To: <4769787e.01b4420a.2b28.ffff88cf@mx.google.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 19 Dec 2007 20:45:52 +0100 Remy Bohmer wrote:

> This patch adds a generic routine to the kernel, so that a map of
> settings can be entered on the kernel commandline.
> 
> Signed-off-by: Remy Bohmer <linux@bohmer.net>
> 
> ---
> ---
>  include/linux/kernel.h |    1 
>  lib/cmdline.c          |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> Index: linux-2.6.24-rc5-rt1/lib/cmdline.c
> ===================================================================
> --- linux-2.6.24-rc5-rt1.orig/lib/cmdline.c	2007-10-09 22:31:38.000000000 +0200
> +++ linux-2.6.24-rc5-rt1/lib/cmdline.c	2007-12-18 21:33:58.000000000 +0100
> @@ -114,6 +115,63 @@ char *get_options(const char *str, int n
>  }
>  
>  /**
> + *	get_map_option - Parse integer from an option map

The @param lines (below) need to go here, immediately following the
function short description (the line above).  No intervening blank
lines.

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

COMMAND_LINE_SIZE varies from 256 to 2048, depending on $ARCH.
That's a bit too much to declare on a function's local stack --
unless you are very certain of the call tree to this point and
that the total stack size is safe.  Can you just kmalloc() this
buf?

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

---
~Randy
