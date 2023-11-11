Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D712B78
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Nov 2023 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="t0t2+PPn"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F44644BA;
	Sat, 11 Nov 2023 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699700683; x=1700305483; i=efault@gmx.de;
	bh=oQncJW6fxmVXjVJSQcOKC+6osWGq3IPaCf8iW6q92rM=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=t0t2+PPnCM7ze+mmKpf+DEB+C2VYQupyvCClGKqDl2+hDLblgT17EZKF9blKu22W
	 nLz8Ja7L7gsxHS54i7D3cSiXbw2rwwlz3sUMhEQw9xjzR4zKLIer6MeAvVmdmyuDy
	 a6KuVpADoRi2+LI6M9MASNr6enZO7w5l0wMJz7SRWdrLIYv/iITDAnbzIwlgZJAjO
	 2RpQj2LY27ta23huEwAkl2YjTgCSmyHGhhhZaCD31+kTQW3AkTFaeEHZfj+ZKDo3O
	 2ehBRwrVcVSRgunZQU6ehFbn1x+tFyKwFUlQ3Lc8HhoEkc7IhV2+k9Ro3sMkJb1dK
	 9YVHxVdCp0iPeCjHwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.30]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1qsNr70TrO-00QzpN; Sat, 11
 Nov 2023 12:04:43 +0100
Message-ID: <2967f1d8bcb74eae68441adc4c08256362042675.camel@gmx.de>
Subject: Re: [ANNOUNCE] 5.10.199-rt97
From: Mike Galbraith <efault@gmx.de>
To: Pavel Machek <pavel@denx.de>, "Luis Claudio R. Goncalves"
	 <lgoncalv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, stable-rt <stable-rt@vger.kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Carsten Emde <C.Emde@osadl.org>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, Tom
 Zanussi <tom.zanussi@linux.intel.com>, Clark Williams
 <williams@redhat.com>, Mark Gross <markgross@kernel.org>, Jeff Brady
 <jeffreyjbrady@gmail.com>
Date: Sat, 11 Nov 2023 12:04:41 +0100
In-Reply-To: <ZU9PPZS/NEL5Pksn@duo.ucw.cz>
References: <169966380957.83297.12867433063716152688@localhost.localdomain>
	 <ZU9PPZS/NEL5Pksn@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1uKpETAQIjwMoD4n080yvhvOyPGl1Cm/UKiExNttcj1x5NPVJFO
 oTgXipfauyf20wuTw47WLcHvnhjBlyGo8nraLGzIqV/Yq/ytHtV28Fi0XIysEFRGAypPtmr
 qYeSMk87CFbMK5tioDAgMmCzpgMG5cN9mOJL8ek09lgvue0FBMm0WpTbr1YOZcP/dOCjKpE
 A/oQtvdAWxHt/H4ULOo+g==
UI-OutboundReport: notjunk:1;M01:P0:fvkCW6TDH+o=;7c0hE51tZoF5dXkJc6KHhTSrK5q
 9nHO9guFJUcGro62t6LL1Y0+doG/8v6uCkssqwp0K9nISsECZkUpsUHGaN1VJmU4ZtyCKKn+0
 t/JKSlwco0gnYDvRYrfx3/YzVACkRY7yzR88I6AIXLCsTCioyLYNCgUTdfZMb8h7j30maJuNI
 Tkagq8OU3AAn0nRNgLPkDokTdoVNEnT5OfzwA4WrEcRX9y8xgJMMuLgANhIYKVAAO4GpovQ67
 GyYgQvbVxXNFptcN0l7PTVWkrka58uBJJ4xQhvGAQe98HBX8jo3vFQruy3720WxMDPSLLPfFm
 8R2w87naGAKqyo6mmm4dMnuByOcpMXuW33VzV+MLz6q4/nlilgeAoJTAEl19RhZ4hyPEnuQAj
 UavghZgnDRkRQPBSQV0/nn60O3CfrQzfgeigUMR65FUwmAi6GjZKGhdgVGtNYyk2X7WC++CGk
 Rr540t/rcsEKOor9iHvNtDSnXxZx6xu7ViggQ/VU3rqX9q+dXw7QScSruC+pAANt68NODcHh5
 I5pSQyYobV97F6DCtsI9WB4bC8GT/CpR4SKfxmUxAbmriHJwZb5HQaqHh1rQFpI+Cx+Hgd5K1
 WODuiFPnP17uc+KGOvajpP0etCerkvLaAshm7l2yZyG8udcpJoGb12+3/BOaQldLhI2KkrnVp
 8zeJ4b49IUAyMiMRQmDkWZHOlO0MH1D8KNQ5w5K2BSmeWFi5whih6LeIe6mJKlYiGD+1LeSB9
 308UCliG+YyO8MNOSQrVpwJgLD0SU4n7PPH9b+ZYDl4zyUPyFAeDd+taICKbRaPd4xF2QNQns
 2+WnTfC3CeyFWTSO3Rx5fOCNtLxBsFb6PZFLYD1jvISrC60JMp4ZWnlFIOcGPCMrvopSqcCkC
 i4aNT7rlYQA3qePXaNkmBT+TNdFB5QELGgTck0N+MyZFOUcsSEWb4vepE1FXkK+0gVa3nUGlW
 Rv6N5zQ2eO9PTa7S50b4mAoiRII=

On Sat, 2023-11-11 at 10:54 +0100, Pavel Machek wrote:
> Hi!
>
> > I'm pleased to announce the 5.10.199-rt97 stable release.
> >
> > This release is an update to the new stable 5.10.199 version and no
> > RT-specific changes were made, with the exception of a fix to a build
> > failure due to upstream changes affecting only the PREEMPT_RT code.
>
> Thanks for the release. Do you plan 5.10.200-based one by chance? .199
> is buggy on hardware we care about, so it would make our job a bit
> easier.

FWIW, the extracted (git format-patch) patch set slid into 5.10.200
here without so much as an offset.

	-Mike
