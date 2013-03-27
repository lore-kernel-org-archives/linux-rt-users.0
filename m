From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: Re: Question on RCU_BOOST option
Date: Wed, 27 Mar 2013 07:50:30 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E0EBE9EC3@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:56150 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab3C0Hul convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Mar 2013 03:50:41 -0400
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paul,

> 
> Perhaps you might want to have a look at this thread, about RCU stalls
> and a possible common root cause for some of them.
> 
> http://marc.info/?l=linux-rt-users&m=136258510132233&w=2

Thanks for the information. However the application is intended to run with 100% CPU (real time) load on one core.
That's why the CPU core is isolated for. They are reserved for this application.
However to keep a system stable, the RCU must still run on this very core.
The one option is to raise the prioriy of ksoftirq (which contains the RCU stuff (if I know right...)) or I was playing with the RCU_BOOST feature which I expected to have the same effect.
However, the RCU_BOOST feature is not clear to me as I still saw the kernel messages about RCU stalls that I did not want to see anymore...

Regards

Mathias



