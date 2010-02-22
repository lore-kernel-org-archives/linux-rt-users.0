From: John Kacur <jkacur@redhat.com>
Subject: Re: [ANNOUNCE] 2.6.33-rc8-rt1
Date: Mon, 22 Feb 2010 13:23:33 +0100
Message-ID: <520f0cf11002220423u64daf89dxa6a4249522adabee@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain>
	 <alpine.LFD.2.00.0910141115020.9428@localhost.localdomain>
	 <alpine.LFD.2.00.0911061743210.12138@localhost.localdomain>
	 <alpine.LFD.2.00.0911101326280.2725@localhost.localdomain>
	 <alpine.LFD.2.00.1001212102220.2906@localhost.localdomain>
	 <alpine.LFD.2.00.1002181748460.2811@localhost.localdomain>
	 <alpine.LFD.2.00.1002212322450.2811@localhost.localdomain>
	 <520f0cf11002220311l2a0caa83lf3ae2817b78501b6@mail.gmail.com>
	 <alpine.LFD.2.00.1002221228130.2811@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Nick Piggin <nickpiggin@yahoo.com.au>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58595 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0BVMXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2010 07:23:34 -0500
In-Reply-To: <alpine.LFD.2.00.1002221228130.2811@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 22, 2010 at 12:28 PM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
> On Mon, 22 Feb 2010, John Kacur wrote:
>> On Mon, Feb 22, 2010 at 12:24 AM, Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> > We are zooming in, but there is still a way to go!
>> >
>>
>> Woohoo! More -rt fun.
>>
>> Unfortunately, I can't log in on my T500 with this kernel though.
>> The following shows-up on my serial console.
>> ------------[ cut here ]------------
>> WARNING: at /home/jkacur/rt.linux.git/net/mac80211/rx.c:2467 ieee802=
11_rx+0x4c/0
>> x721 [mac80211]()
>
> Fix below. Thanks,
>
> =A0 =A0tglx
> ----
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 82a30c1..e735c17 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -2464,7 +2464,7 @@ void ieee80211_rx(struct ieee80211_hw *hw, stru=
ct sk_buff *skb)
> =A0 =A0 =A0 =A0struct ieee80211_supported_band *sband;
> =A0 =A0 =A0 =A0struct ieee80211_rx_status *status =3D IEEE80211_SKB_R=
XCB(skb);
>
> - =A0 =A0 =A0 WARN_ON_ONCE(softirq_count() =3D=3D 0);
> + =A0 =A0 =A0 WARN_ON_ONCE_NONRT(softirq_count() =3D=3D 0);
>
> =A0 =A0 =A0 =A0if (WARN_ON(status->band < 0 ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status->band >=3D IEEE80211_NU=
M_BANDS))
> --

Thanks Thomas

That patch fixes the symptom I reported, but unfortunately, I still
can't log-in to my laptop without the machine freezing.
Not sure why, investigating.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
