From: Sebastian Ohl <sebastian+ml.linux-rt@ohl.name>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Wed, 27 Jul 2011 18:52:56 +0200
Message-ID: <4E304268.7080509@ohl.name>
References: <alpine.LFD.2.02.1107241223560.2702@ionos>
Reply-To: sebastian@ohl.name
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns.vrs51476.i4e-server.de ([87.118.88.254]:47942 "EHLO
	failure.foobarquux.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910Ab1G0RAv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jul 2011 13:00:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by failure.foobarquux.de (Postfix) with ESMTP id 569D3DCA49
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jul 2011 18:52:57 +0200 (CEST)
Received: from failure.foobarquux.de ([127.0.0.1])
	by localhost (failure.foobarquux.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jzf3zl35wcUD for <linux-rt-users@vger.kernel.org>;
	Wed, 27 Jul 2011 18:52:56 +0200 (CEST)
Received: from [134.169.48.150] (irt20.ifr.ing.tu-bs.de [134.169.48.150])
	by failure.foobarquux.de (Postfix) with ESMTPSA id 75A43DCA48
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Jul 2011 18:52:56 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.02.1107241223560.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey folks,

i just tried to compile the new rt patch and i was wondering why i
cannot select 4GB or 64GB of memory if i am selecting full preemption?
in my old rt kernel (2.6.33.1) this hasn't been a problem.

what are the implications if i am using only the basic RT option?

Regards
 Sebastian Ohl

--=20
Dipl.-Inform. Sebastian Ohl
Institut f=FCr Regelungstechnik     | Tel.(BS): (0531) 391-3824
Lehrstuhl f=FCr el. Fahrzeugsysteme | Tel.(WOB): (0531) 391-63057
TU Braunschweig                   | Fax: (0531) 391-5194
http://www.ifr.ing.tu-bs.de       | Email: ohl@ifr.ing.tu-bs.de

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
