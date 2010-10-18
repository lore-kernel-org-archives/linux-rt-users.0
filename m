From: jordan <triplesquarednine@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Mon, 18 Oct 2010 03:12:10 -0400
Message-ID: <AANLkTi=q5wn_WjMp-qfMV8ocC3-bMeZC-h=owsge4jY+@mail.gmail.com>
References: <AANLkTi=Z2gOMi1=FtX6vbJUw68deVRyN7wfMV1jA-0qz@mail.gmail.com>
	<309019044.619711287382567906.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Clark Williams <williams@redhat.com>,
	Daniel James <daniel@64studio.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org,
	Bernardo Barros <bernardobarros2@gmail.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64294 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab0JRHMM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Oct 2010 03:12:12 -0400
Received: by ewy20 with SMTP id 20so1166352ewy.19
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Oct 2010 00:12:11 -0700 (PDT)
In-Reply-To: <309019044.619711287382567906.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Agreed,

No newbie should be doing these hacks, these were just for Bernardo as
he was looking for an alternative
to RT which he seemed to not be able to get to work on his system properly...

And yes, it isn't realtime linux and the PREEMPT_RT Patch. it is a
different patch set that can provide low latency, some performance
tweaks, that can operate suitably well for pro-audio/media production
on linux, but attained using an entirely different method all
together. Not recommended if you don't understand
what is going on there to some degree... ;)

i wouldn't be using this method, if my laptop wasn't so crappy (buggy hardware).
This is the only method that works well on this computer, and is much
more stable than RT runs...
While still allowing me to accomplish what realtime linux and the
PREEMPT_RT Patch allowed me to do
on this machine, in this kind of use case.

(rt-kernel is ideal)

jordan
