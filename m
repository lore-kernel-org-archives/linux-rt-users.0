From: Daniel James <daniel@64studio.com>
Subject: Re: preempt rt in commercial use
Date: Thu, 16 Sep 2010 11:07:22 +0100
Message-ID: <4C91EC5A.7070105@64studio.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rom012.server4you.de ([62.75.222.127]:37458 "EHLO
	rom012.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0IPKHl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 06:07:41 -0400
In-Reply-To: <AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jordan,

> Next, in the Pro-audio sector, you have Muse Research who make the
> "Recepter".  Which is a hardware VST host.

That's just one example of many in the pro audio sector (that we know
about, since the companies involved aren't required to disclose their
use of GNU/Linux - it's a competitive advantage, so they have a
disincentive to do so). Several flagship audio mixing and recording
systems use the Linux kernel, including the Harrison Xrange:

http://www.harrisonconsoles.com/joomla/index.php?option=com_content&task=view&id=26&Itemid=51

and the Midas XL8:

http://www.midasconsoles.com/xl8.php

If you have been to see a Hollywood movie, or attended a stadium gig on
a rock band's world tour, you have almost certainly been listening to
audio mixed on a Harrison or Midas console - these companies are at the
top of their game.

RT-Linux provides significant advantage for these companies over
proprietary RTOS products because of time-to-market, not licence costs:
there are many audio software components available for re-use, leaving
the integrator to write the last parts of the code.

There's also knowledge transfer from the Linux HPC sector - for example,
the Xrange uses up to 120 Opteron CPUs, so it's hardly a 'desktop'
system. You don't get that combination of high performance and reliable,
re-usable source code with any other platform, RT or otherwise.

Licence fees for proprietary software aren't the big deal for companies
selling a relatively small number of expensive products. I think people
get confused with consumer products like mobile phones, where it's
supposedly all about volume. Actually, I think the independence of OEM's
from proprietary software vendors has more to do with it. Microsoft has
significant lock-in with consumers, and yet it still can't persuade
people to buy Windows phones :-)

Cheers!

Daniel
