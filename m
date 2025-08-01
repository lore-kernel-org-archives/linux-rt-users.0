Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126F18C034
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Aug 2025 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016391; cv=none; b=Casx4aF43pzObh4c92TZMmlV5swf7DoI9b0qsKRgR/yjX2BTqAzkZTtdipERhWP0zIZMqqzeiEgB1rZiQQOVATxDz2dOs/jxLMxKNdT6r3YHWKQIQAoX7eO+BMH/GECNBkTTfAhlxEiG90JqHCFXiOLqwt/b3PENAG8dVoPHg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016391; c=relaxed/simple;
	bh=jo7Y29oe76XgtueZgw8z9jTf3nI46rw0Ba7wztDJPnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osO/QqgXctkv38r0KdCoGzCWW7QGXGecvifUDN7dTQRX7zxIvCRelNWEe57LC8BOjynGr2ivqw66zGjk5rZIpbEHYD/cp0OSzlzp14oJqlmx1eTkihDiAL8FZ/eWs7tiqC7mSvKNHGF9E8ajk7RVDYQ836w1U8e6yWsPi1Ne1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=NR55NY2X; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="NR55NY2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754016386; x=1754621186; i=efault@gmx.de;
	bh=OZjzgheKUHHzd1RZo0yhm7HuB0fzrr1IWLPKAHg38yQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NR55NY2XmGM+B6hp8fDM9b9vOSKRRdnaVjzDc5WpuAQPmaWZpyXNZbBVBqQnfRwN
	 gHPMO0r0vZi92cV07Lrqt2by/KzyWcoCNkpwezOo8Khp5Rr5ohCUc+BNim/hfeHcC
	 Wua6IZsMPTYuueWp3g++22WFqA52CCaWRqxed5XFe82PVAnC20fMFzfg/0I5KbIZu
	 ap/PubPrJmsR+9KDjDk//a/6ZfQyi7whgJ4WEJ8I85TnrhFm9x3pQlOL+5aFKGWzs
	 K7gE+/YWi9Zh2M4HMJftYoNN5t3wq25OPt8d5Kt8nMWEkDHMlUlwD2WeTYT2LFMFk
	 RPxniMi+LFAhLSt7jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1u5r8G11Is-00o939; Fri, 01
 Aug 2025 04:46:26 +0200
Message-ID: <026de9fcd4f0ed17c2df95c4f7c56b878a844012.camel@gmx.de>
Subject: Re: Realtime threads delayed due to kcompactd0
From: Mike Galbraith <efault@gmx.de>
To: Vlastimil Babka <vbabka@suse.cz>, Frank van der Linden
 <fvdl@google.com>,  Alexander Krabler <Alexander.Krabler@kuka.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
	"linux-mm@kvack.org"
	 <linux-mm@kvack.org>, Dennis Schimmel <Dennis.Schimmel@kuka.com>, Daniel
	Braunwarth <Daniel.Braunwarth@kuka.com>
Date: Fri, 01 Aug 2025 04:46:24 +0200
In-Reply-To: <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz>
References: 
	<DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com>
	 <CAPTztWYf82p6hq=Q2mVq6_9WTjRaQiH81z4idZL6MZ1PXufPwQ@mail.gmail.com>
	 <71df781c-3ef3-4b26-9ba8-93fc7d4f9eec@suse.cz>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:dd9ml/xjV/fyreDw1IhL02nv3C0HFPR0UxyHbaThvfvbXeWPiz8
 sHhdz4k1uAa1c1IMzCy2kTvoParuv9jXitBur/V49W1xZFu33hiGg+/WLHcFloNVUruaPkK
 vY35O4YCLkp1ZPoJyyripwNXynRW7bjy8beWkTf4Ro9A+bREhF+eZs8EUiEMnfVCT8cB3dX
 qIrWEWdvDRRC2csWozmJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TD4NESOZaj0=;24N7s86a8TZKyYSo8I5YjSFtw2u
 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
 4mKruFMLzFA==

On Thu, 2025-07-31 at 20:41 +0200, Vlastimil Babka wrote:
> On 7/31/25 20:34, Frank van der Linden wrote:
> > Not sure what the right thing to do would be. Either explicitly boost
> > the priority of a thread temporarily during migrate_pages_batch, or
> > mitigate the issue by dealing with 'busy' pages more quickly in
> > migrate_pages_batch.
>=20
> There's a workaround for realtime tasks. If you mlock[all]() their memory=
,
> setting sysctl vm.compact_unevictable_allowed to 0 should exclude these
> pages from migration by compaction.

Hm, per documentation that's done automatically for PREEMPT_RT...

On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fault,=
 due
to compaction, which would block the task from becoming active until the fa=
ult
is resolved.

...but rummaging, seems other stuff can step on it (contiguous alloc?).

	-Mike
