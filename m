From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Missing figures in RT_PREEMPT_HOWTO
Date: Mon, 20 Nov 2006 10:56:36 +0100
Message-ID: <45617BD4.7030103@stud.feec.vutbr.cz>
References: <45608487.4020309@gmail.com> <20061119164846.GO18636@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dirk Behme <dirk.behme@googlemail.com>, l.fu@pengutronix.de,
	Juergen Beisert <jbe@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:24060 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S965291AbWKTJ4m (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Nov 2006 04:56:42 -0500
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20061119164846.GO18636@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Robert Schwebel wrote:
> As the document states, the primary source is still the DocBook, not the
> Wiki. Juergen has reworked quite some parts of the documents, including
> the 2pt screenshots :-) , I assume he will check it in during the next
> days.  
> 
> I've added your changes in the Wiki to the DocBook document, to make
> sure they don't disappear at the next update. Next time better check out
> the svn from our server and send me patches against the latest version.

I didn't notice that and I've recently added some content to the Wiki 
too. I see that you've added my changes to the DocBook, good. Next time 
I'll send patches against that. But how do I checkout from the SVN?

I tried
svn co https://iocaste.penguin.de/viewsvn/rt-preempt-howto/trunk/
but this doesn't work. I'm getting:
svn: PROPFIND request failed on '/viewsvn/rt-preempt-howto/trunk'
svn: PROPFIND of '/viewsvn/rt-preempt-howto/trunk': 301 Moved 
(https://iocaste.penguin.de)

Michal

