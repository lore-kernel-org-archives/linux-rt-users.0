From: Alessio Igor Bogani <abogani@texware.it>
Subject: Re: 2.6.20-rt5 Oops on boot
Date: Wed, 14 Feb 2007 15:14:45 +0100
Message-ID: <1171462485.6360.7.camel@godzilla.tecnorama.it>
References: <200702101551.l1AFpKUf019229@cichlid.com>
	 <Pine.LNX.4.64.0702141451540.7817@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:55759 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290AbXBNOPF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Feb 2007 09:15:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id 4DC6F6080C9
	for <linux-rt-users@vger.kernel.org>; Wed, 14 Feb 2007 15:15:02 +0100 (CET)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qy2o-cB56S8d for <linux-rt-users@vger.kernel.org>;
	Wed, 14 Feb 2007 15:14:53 +0100 (CET)
Received: from [192.168.100.121] (adsl203-157-083.mclink.it [213.203.157.83])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id B67F3608073
	for <linux-rt-users@vger.kernel.org>; Wed, 14 Feb 2007 15:14:52 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0702141451540.7817@frodo.shire>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi All,

> >> I have terrible news: 2.6.20-rt5 does not boot at all on a couple
> >> machines I was brave enough to try -- a P4@3.3Ghz SMP/HT desktop, and a
> >> Core2 Duo T7200@2.0Ghz laptop.
> >
> > Ditto for me on an ASUS AMD64 x2, just hangs, I have no
> > serial console. 2.6.20-rc5-rt7 booted ok (the last one I
> > tried). Both using SMP.
>
> 2.6.20-rt5 doesn't boot on my hyperthreaded Pentium 4 2.80GHz either. I 
> don't have serial console but I can see that it stops at exit.c:877.

Only for feedback:
On my P4 3.0GHz HT the 2.6.20-rt5 (Ubuntu) boot perfectly.

Ciao,
Alessio
