From: "M. Koehrer" <mathias_koehrer@arcor.de>
Subject: Re: RE: Looking for a real time IPC to be used with select
Date: Mon, 19 Apr 2010 08:24:45 +0200 (CEST)
Message-ID: <12661775.1271658285744.JavaMail.ngmail@webmail18.arcor-online.net>
References: <8C8865ED624BB94F8FE50259E2B5C5B304610C21FF@palmail03.lsi.com> <3215024.1271427173625.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: robert.leyendecker@lsi.com, mathias_koehrer@arcor.de,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:60592 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751729Ab0DSGYr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Apr 2010 02:24:47 -0400
In-Reply-To: <8C8865ED624BB94F8FE50259E2B5C5B304610C21FF@palmail03.lsi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Robert, 

thanks for the reply.

> > My question is now: What kind of IPC is preferred here?
> > The only IPC I see is a local socket communication, however
> > this looks like a huge overhead for triggering...
> > 
> > Both, threads A and B are real time threads, thus any IPC in use
> > should be supported by the RT_PREEMPT patch.
> You could try pipe() and take a look at epoll(). My testing shows it's
> reasonably efficient and the epoll() API is quite flexible.  
> 
> I've thought about using eventfd() and epoll() for exactly the purpose you
> mention but haven't had time to try it. 
eventfd() looks very interesting.
I think I will do a test using it.

Mathias

-- 
Mathias Koehrer
mathias_koehrer@arcor.de


Traumziele - von Beschreibung bis Buchung jetzt kompakt auf den Reise-Seiten von Arcor.de! http://www.arcor.de/rd/footer.reise
