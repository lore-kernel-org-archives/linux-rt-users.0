From: Mike Galbraith <efault@gmx.de>
Subject: Re: Latency problem
Date: Fri, 28 Oct 2011 06:54:03 +0200
Message-ID: <1319777643.6150.7.camel@marge.simson.net>
References: <CAE_Gge02PZyZ93wSyH8uSJAQ6wdZRqG-L-qumV23g4Tam7BUmQ@mail.gmail.com>
	 <1319741477.6197.26.camel@marge.simson.net>
	 <CAE_Gge3nBE4_Jm39qnVz_6ieBpJL6b9qNd41snW=6bi9cggm3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Rapha=EBl?= Beamonte <raphael.beamonte@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44290 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751595Ab1J1EyH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Oct 2011 00:54:07 -0400
In-Reply-To: <CAE_Gge3nBE4_Jm39qnVz_6ieBpJL6b9qNd41snW=6bi9cggm3g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-10-27 at 15:03 -0400, Rapha=C3=ABl Beamonte wrote:

> Moreover, the use of hwlatdetect seems to confirm that the problem is
> from hardware.

Yeah, skimmed over your message too quick, thinking nsecs instead of
usecs.  Probably SMIs.

	-Mike=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
