From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 17:35:16 +0200
Message-ID: <1185377716.30975.11.camel@godzilla.tecnorama.it>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu>
	 <46A4B7C2.1070304@free.fr> <20070723160442.GA7995@elte.hu>
	 <46A5B8E3.4060004@free.fr> <46A74A58.1070704@free.fr>
	 <20070725130536.GA12334@elte.hu> <46A74E05.50504@free.fr>
	 <20070725133835.GA17616@elte.hu>  <46A758B5.9070602@free.fr>
	 <1185372808.23485.2.camel@godzilla.tecnorama.it> <46A75F97.8000103@free.fr>
	 <1185375620.29693.1.camel@godzilla.tecnorama.it> <46A76A7C.3090805@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:39546 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760339AbXGYPfU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 11:35:20 -0400
In-Reply-To: <46A76A7C.3090805@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi John,

On Wed, 2007-07-25 at 17:21 +0200, John Sigler wrote:
[...]
> > Do you have a regular distro or custom system on this machine?
> 
> The system is based on Linux From Scratch.
> Why do you ask? What did you see in the output I provided?

Because i never see output as you provided to this list.

In any case i suggest you to install an hard drive to this machine,
install Fedora* or Ubuntu, install a -rt precompiled kernel package
(with yum or apt) and finally test you application.

In this way you can discover if the problem is into your kernel,
application or hardware.

Ciao,
Alessio

(*) Precompiled kernel package with rt patchset for Fedora is packaged
by Ingo Molnar. 
