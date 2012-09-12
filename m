From: "Tim Sander" <tim.sander@hbm.com>
Subject: Re: Improving ARM7 platform performance with CONFIG_PREEMPT_RT
Date: Wed, 12 Sep 2012 13:27:46 +0200
Message-ID: <24505532.imcAdKUU0T@dabox>
References: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "Hartmut Behrens" <hartmut.behrens@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay.medianet-world.de ([213.157.0.172]:49963 "HELO
	relay.medianet-world.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751737Ab2ILL1w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Sep 2012 07:27:52 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <CA+69FtBGGHQykr8DiOizeR0pWA+5ifeN1LtzZ2n2LmeA6+TWRg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Hartmut
> Is this the best performance that can be expected from ARM7/9 platforms?
Look there 
https://www.osadl.org/Latency-plot-of-system-in-rack-2-slot.qa-latencyplot-r2s3.0.html
There are also other OMAP devices in the nice testrack of the OSADL guys.

Further i would suppose to switch of power management (look also for the cpu idle stuff).
The advanced power saving mechanisms can create some unwanted latency.

Best regards
Tim

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.
