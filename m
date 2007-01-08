From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Mon, 8 Jan 2007 11:28:56 +0100
Message-ID: <20070108102856.GA15514@pengutronix.de>
References: <459CE84F.8000009@imc-berlin.de> <20070104115215.GN29495@pengutronix.de> <459CFDF1.80807@imc-berlin.de> <1167917257.23138.17.camel@localhost.localdomain> <459D16D1.4040306@imc-berlin.de> <1167986882.23138.52.camel@localhost.localdomain> <45A21888.8060702@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:58988 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161216AbXAHK25 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jan 2007 05:28:57 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <45A21888.8060702@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jan 08, 2007 at 11:10:16AM +0100, Steven Scholz wrote:
> As I wrote I have problems linking it statically!
> 
>  gcc -Wall -O2  -lpthread -lrt cyclictest.c -o cyclictest -static
> 
> results in

...
 
> while
> 
>  gcc -Wall -O2 cyclictest.c -o cyclictest -lrt -lpthread -static
> 
> compiles and links fine!
> 
> Any idea why the order matters?

The order does always matter. From 'info gcc': 

     It makes a difference where in the command you write this option;
     the linker searches and processes libraries and object files in
     the order they are specified.  Thus, `foo.o -lz bar.o' searches
     library `z' after file `foo.o' but before `bar.o'.  If `bar.o'
     refers to functions in `z', those functions may not be loaded.

So in your first case, run with -v to see the linker options:

rsc@isonoe:~/tmp/cyclictest$ gcc -v -Wall -O2  -lpthread -lrt cyclictest.c -o cyclictest -static 2>&1 | grep collect2
 /usr/lib/gcc/i486-linux-gnu/4.1.2/collect2 -m elf_i386 -static -o
cyclictest /usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crt1.o
/usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crti.o
/usr/lib/gcc/i486-linux-gnu/4.1.2/crtbeginT.o
-L/usr/lib/gcc/i486-linux-gnu/4.1.2 -L/usr/lib/gcc/i486-linux-gnu/4.1.2
-L/usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib -L/lib/../lib
-L/usr/lib/../lib -lpthread -lrt /tmp/cc2ooNdo.o --start-group -lgcc
-lgcc_eh -lc --end-group /usr/lib/gcc/i486-linux-gnu/4.1.2/crtend.o
/usr/lib/gcc/i486-linux-gnu/4.1.2/../../../../lib/crtn.o
collect2: ld returned 1 exit status

... crt1.o crti.o crtbeginT.o -lpthread -lrt cc2ooNdo.o crtend.o

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
