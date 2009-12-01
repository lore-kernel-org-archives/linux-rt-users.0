From: Yogesh Chaudhari <mr.yogesh@gmail.com>
Subject: Re: Ethernet issues with lite5200 board from linux-2.6.31
Date: Tue, 1 Dec 2009 11:18:58 +0530
Message-ID: <d1f76ba30911302148t2bfceed0w79515dccc31b0bc3@mail.gmail.com>
References: <d1f76ba30911300038w272578dfx9adb116bde493e00@mail.gmail.com>
	<d1f76ba30911300150g10c1382clb2958245ebf94362@mail.gmail.com>
	<1259590999.12870.0.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Mark Knecht <markknecht@gmail.com>,
	John Kacur <jkacur@redhat.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:56390 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbZLAFtM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Dec 2009 00:49:12 -0500
In-Reply-To: <1259590999.12870.0.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2009/11/30 Steven Rostedt <rostedt@goodmis.org>:
> On Mon, 2009-11-30 at 15:20 +0530, Yogesh Chaudhari wrote:
>> Hello,
>> =A0 =A0 =A0 =A0 =A0I am running linux kernel with rt patch on embedd=
ed board
>> based on lite5200 eval board. From linux-2.6.31 release, in which th=
e
>> mdio patch has gone inside, =A0the fec ethernet does not come up on =
this
>> board. I get the following message at startup:
>> mpc52xx MII bus: probed
>
> Do you see the same issue without adding the rt patch?
This issue is present even without the rt patch.
>
> -- Steve
>
>
>



--=20
DREAM IT, CODE IT

"CODITO, ERGO SUM"
"I CODE, THEREFORE I AM"
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
