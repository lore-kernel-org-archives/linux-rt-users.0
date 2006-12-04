From: Robert Schwebel <robert@schwebel.de>
Subject: Re: Missing figures in RT_PREEMPT_HOWTO
Date: Mon, 4 Dec 2006 11:18:24 +0100
Message-ID: <20061204101824.GJ1434@pengutronix.de>
References: <45608487.4020309@gmail.com> <20061119164846.GO18636@pengutronix.de> <45617BD4.7030103@stud.feec.vutbr.cz> <20061122120330.GD18636@pengutronix.de> <456B54F1.3030408@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	Dirk Behme <dirk.behme@googlemail.com>, l.fu@pengutronix.de,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:21706 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S935596AbWLDKSa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Dec 2006 05:18:30 -0500
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Content-Disposition: inline
In-Reply-To: <456B54F1.3030408@stud.feec.vutbr.cz>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Nov 27, 2006 at 10:13:21PM +0100, Michal Schmidt wrote:
> Robert Schwebel skrev:
> >I've ported the changes from the wiki diff output; please send me a diff
> >with a correct credit line for the document header. I suppose I've not
> >correctly seen who made which changes.
> 
> Here's a patch fixing a slight confusion, where the description of 
> threaded IRQs seemed to suggest that they're executed either in user or 
> kernel context, while the real distinction is interrupt/process context.
> It also adds myself to the document header and updates the revhistory.

Committed, please re-check.

Robert 
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
