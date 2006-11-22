From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Missing figures in RT_PREEMPT_HOWTO
Date: Wed, 22 Nov 2006 13:03:30 +0100
Message-ID: <20061122120330.GD18636@pengutronix.de>
References: <45608487.4020309@gmail.com> <20061119164846.GO18636@pengutronix.de> <45617BD4.7030103@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Dirk Behme <dirk.behme@googlemail.com>, l.fu@pengutronix.de,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:17290 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1753738AbWKVMDg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Nov 2006 07:03:36 -0500
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Content-Disposition: inline
In-Reply-To: <45617BD4.7030103@stud.feec.vutbr.cz>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Michael,

On Mon, Nov 20, 2006 at 10:56:36AM +0100, Michal Schmidt wrote:
> Robert Schwebel wrote:
> >As the document states, the primary source is still the DocBook, not the
> >Wiki. Juergen has reworked quite some parts of the documents, including
> >the 2pt screenshots :-) , I assume he will check it in during the next
> >days.  
> >
> >I've added your changes in the Wiki to the DocBook document, to make
> >sure they don't disappear at the next update. Next time better check out
> >the svn from our server and send me patches against the latest version.
> 
> I didn't notice that and I've recently added some content to the Wiki 
> too. I see that you've added my changes to the DocBook, good. Next time 
> I'll send patches against that. But how do I checkout from the SVN?

I've ported the changes from the wiki diff output; please send me a diff
with a correct credit line for the document header. I suppose I've not
correctly seen who made which changes.
 
> I tried
> svn co https://iocaste.penguin.de/viewsvn/rt-preempt-howto/trunk/
> but this doesn't work. I'm getting:
> svn: PROPFIND request failed on '/viewsvn/rt-preempt-howto/trunk'
> svn: PROPFIND of '/viewsvn/rt-preempt-howto/trunk': 301 Moved 
> (https://iocaste.penguin.de)

The URL with "viewsvn" is for online viewing, replace it by "svn" and it
should work.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
