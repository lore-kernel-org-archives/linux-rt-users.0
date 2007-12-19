From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [patch 1/3] Add generic routine for parsing map-like options on kernel cmd-line (repost:CC to LKML)
Date: Wed, 19 Dec 2007 22:44:10 +0100
Message-ID: <3efb10970712191344l7656f2b3m8d9fbde193f39eaa@mail.gmail.com>
References: <20071219194551.315868746@bohmer.net>
	 <4769787e.01b4420a.2b28.ffff88cf@mx.google.com>
	 <20071219130059.d99489d1.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Juergen Beisert" <jbe@pengutronix.de>,
	"Darren Hart" <dvhltc@us.ibm.com>, linux-rt-users@vger.kernel.org,
	"Sven-Thorsten Dietrich" <sdietrich@novell.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.176]:49716 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbXLSVoL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2007 16:44:11 -0500
Received: by ro-out-1112.google.com with SMTP id p4so4058188roc.5
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Dec 2007 13:44:11 -0800 (PST)
In-Reply-To: <20071219130059.d99489d1.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Randy,

Sorry for the language errors, English is not my Native language, so I
make these stupid errors...

> > + *   get_map_option - Parse integer from an option map
> The @param lines (below) need to go here, immediately following the
> function short description (the line above).  No intervening blank
> lines.

OK, I will adapt that.

> > +int get_map_option(const char *str, const char *key, int *pint)
> > +{
> > +     char  buf[COMMAND_LINE_SIZE];
>
> COMMAND_LINE_SIZE varies from 256 to 2048, depending on $ARCH.
> That's a bit too much to declare on a function's local stack --
> unless you are very certain of the call tree to this point and
> that the total stack size is safe.  Can you just kmalloc() this
> buf?

I know it is big on a 4k stack, and I also think it is not very nice...
But kmalloc() panics the kernel if I do it as soon as in the __setup() code.

The problem is that the original string may not be modified by the
cmdline-parser, and I do not know the length of the command up front,
(except that it cannot be longer than this define). Allocating a
global buffer is not safe and needs locking. So actually only what
left for me was the stack... or rewrite the used C-library-routines
completely myself, for this purpose only, which is also not nice.

I hope someone could point to me to another possibilty, that I did not
think of yet.


Kind Regards,

Remy

>
> > +     char  *p, *substr;
> > +     int   found = 0;
> > +
> > +     /* We must copy the string to the stack, because strsep()
> > +        changes it.*/
> > +     strncpy(buf, str, COMMAND_LINE_SIZE);
> > +     buf[COMMAND_LINE_SIZE-1] = '\0';
> > +
> > +     p = buf;
> > +     substr = strsep(&p, ",");
> > +     while ((!found) && (substr != NULL)) {
> > +             if (strlen(substr) != 0) {
> > +                     if (key == NULL) {
> > +                             /* Check for the absence of any ':' */
> > +                             if (strchr(substr, ':') == NULL) {
> > +                                     sscanf(substr, "%d", pint);
> > +                                     found = 1;
> > +                             }
> > +                     } else {
> > +                             /* check if the first part of the key matches */
> > +                             if (!strncmp(substr, key, strlen(key))) {
> > +                                     substr += strlen(key);
> > +                                     /* Now the next char must be a ':',
> > +                                        if not, search for the next match */
> > +                                     if (*substr == ':') {
> > +                                             substr++;
> > +                                             sscanf(substr, "%d", pint);
> > +                                             found = 1;
> > +                                     }
> > +                             }
> > +                     }
> > +             }
> > +             substr = strsep(&p, ",");
> > +     }
> > +     return found;
> > +}
>
> ---
> ~Randy
>
