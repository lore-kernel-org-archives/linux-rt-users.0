Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B0182D7;
	Fri, 27 Dec 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735313028; cv=none; b=dbhLbwLOPMAPLJ9OW/B81xmyqSoUDxrrVc2fYskejXN6cVECoASdSh0Z1qCWnndN6qZmSXiEnx7nq5xEV2Yg8BHK2hHXeqOPnR46qR0Ky0k1jZNnaiybt8hEFu3kqG3F6YFCOEMR5nYgnATOTEg251oU0s18juEkPBaMN9abgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735313028; c=relaxed/simple;
	bh=p2uw9NIucKOFKeva1sLsFCD6lHqn8fDCTWKrYCs6IP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXz8HJ2lVM/6mSW06jxgWXsXt8hMgGH/pzJzBSMQZ/WfMViJTYdVVEJmN5q+Dz1W28DVON6J3kkLq7rVojyOFdSsgE+X36lJO7vLhD8eCQMyftMfYM6wN/GxYXWErbM8rj3Ac8zrCagCfifmCZy/N/b1ixZoebgSGEwXK8rLjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO+2BuZ7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO+2BuZ7"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d84179ef26so8586665a12.3;
        Fri, 27 Dec 2024 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735313024; x=1735917824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCs4SlopR+ytvWKb1mRTIOdLb2VauVpUgasSZ/m8RTQ=;
        b=RO+2BuZ7MQHuIg08b787zKqTefphKQwqXWQHJTeMTjqIpUPo/30TjEyN3umapZXh1C
         Jr/irQr5NM0Y4df9muNWM2u84Y5eWGYGBhiJAfmFaPGTSySeyHe4xcjkW1Wy4at/Muqh
         I9cfof1kf8K7lZCgTSVf4DqhPdTuQVR3ClOjT0IsDwHXa3vTj79+lrDCj9SUrTKHS5n3
         iWnqW82qPCOyxRW/b02Aov+QgPBdYgXAqaf6a8Wp6OJIaUqixw5Y9MgLLaBDK6wggMhV
         utGgTZyxK0gyMsQwNOVFauh9kryeg4G5p8/gyO9ZpR10M8llLW0w0K0mMxaIHYcaZ4vv
         jbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735313024; x=1735917824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCs4SlopR+ytvWKb1mRTIOdLb2VauVpUgasSZ/m8RTQ=;
        b=DVO8MS7m+MaD7GvBg5ynxUeTBSDMQXxf6JFNVqKkuC6jnfyYBEk5C9+6YLVfrzVQY7
         ohQ0rupXcTZmF3wmrVcwrmMNnZiB8Dne33ZjWbx48y8YaVTe63KjVA7F4jTQNGWXcJDh
         epBQmJ+t1VMuCkd+YF5md3lNAAHTqmpKXyWlrt6B3U+1bofLkygnktFK0VTGzB3BJgtj
         0ukT+M1O42Zreo66Zil2xTa4l2X4qVQ7US731YKF6YzQ+j7o1dy5O9X0koLxHzdt9Je+
         gd6L7rLex8v8jfqN6L6sMj74GkSnn3YdntXrCIzvaj8aS9YrloM4yOS20Kw8L4t/AotM
         Oxiw==
X-Forwarded-Encrypted: i=1; AJvYcCVFVjR0MiRXD/5EojdgqafGmmGWmQBqe/y4La6japVUnMhvzHZJaPL0SqGxvlbbxnOZSP6DuSW6DvvNQzvo0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WTgFDczBtA6v24cZKVrlgTBYRzKeOk+gmN/b9Im64Hv0W2Dk
	DWDKeLAsV7hXCYWfwLNw6vqqASyfIN+P6yFD4iMri/QSH3Rs8scG
X-Gm-Gg: ASbGncuRj6LaIqWs/Nf8PRnkvgGQi3zKnHA8Tt/ZFvuUCGJ480ydP5MX6j81HhpP1f4
	m4ftal4AaKNzvg/hfTUSKgEpePZQftMCTUp64JbFPGaOZhVfqnW39mAYgtkVIE34SnyJVW/jlIe
	fzGAmhO2NdpanvNdzvpV/PlwprT5OeKa6oYjsSooIffDdGgmzvgLwDond6VX0R1BrkjR9yJ0i8V
	tKlU6LHGJgoFA/iIQC9n/lBQdWs0wj4gBB6xCvc8lrjVQps1FIlo8ZqGBCOOijtB6K72o/xKPcA
	KF2dcXDk1fjkzv+W
X-Google-Smtp-Source: AGHT+IFziw4N6SobadAsfHw5pcajIYjBdYLhOE/fsezZVoh8zM3U/uDcfHW+aI6C8mUgmCbBY3dSgQ==
X-Received: by 2002:a05:6402:2345:b0:5d1:2377:5afc with SMTP id 4fb4d7f45d1cf-5d81dd66e6amr22937333a12.3.1735313024222;
        Fri, 27 Dec 2024 07:23:44 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d807616bc1sm11228754a12.29.2024.12.27.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 07:23:42 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 65B7CBE2EE7; Fri, 27 Dec 2024 16:23:41 +0100 (CET)
Date: Fri, 27 Dec 2024 16:23:41 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Pavel Machek <pavel@denx.de>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: 6.1.120-rt46 and build failure due to conflict with rebase against
 34d21de99cea ("net: Move {l,t,d}stats allocation to core and convert veth &
 vrf") (was: Re: [ANNOUNCE] 6.1.120-rt46)
Message-ID: <Z27GfUftoDlw25R4@eldamar.lan>
References: <173446426761.810839.10241405280484476684@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173446426761.810839.10241405280484476684@demetrius>

Hi,

On Tue, Dec 17, 2024 at 07:37:47PM -0000, Clark Williams wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 6.1.120-rt46 stable release.
> 
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v6.1-rt
>   Head SHA1: 061eae4897c2fee62fed3f946864107faf3292b7
> 
> Or to build 6.1.120-rt46 directly, the following patches should be applied:
> 
>   https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz
> 
>   https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.120.xz
> 
>   https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.120-rt46.patch.xz
> 
> 
> Enjoy!
> Clark
> 
> Changes from v6.1.119-rt45:

In v6.1.120 there was a backport of 34d21de99cea ("net: Move
{l,t,d}stats allocation to core and convert veth & vrf") .

AFAICS, this conflicts with the v6.1.120-rt46, in the patch

0005-net-Remove-the-obsolte-u64_stats_fetch_-_irq-users-d.patch

and causes a build failure:

/home/build/linux-6.1.122/debian/build/source_rt/drivers/net/vrf.c: In function ‘vrf_get_stats64’:
/home/build/linux-6.1.122/debian/build/source_rt/drivers/net/vrf.c:157:41: error: ‘const struct pcpu_dstats’ has no member named ‘rx_pkts’; did you mean ‘rx_packets’?
  157 |                         rpkts = dstats->rx_pkts;
      |                                         ^~~~~~~
      |                                         rx_packets


I guess the rt patchset for 6.1.120 was just not cleanly rebased for
the 0005-net-Remove-the-obsolte-u64_stats_fetch_-_irq-users-d.patch
patch:

--- a/0005-net-Remove-the-obsolte-u64_stats_fetch_-_irq-users-d.patch
+++ b/0005-net-Remove-the-obsolte-u64_stats_fetch_-_irq-users-d.patch
@@ -2012,7 +2012,7 @@ index c8a1009d659e..c3e5fb98cf7f 100644
                        rbytes = dstats->rx_bytes;
 -                      rpkts = dstats->rx_packets;
 -              } while (u64_stats_fetch_retry_irq(&dstats->syncp, start));
-+                      rpkts = dstats->rx_pkts;
++                      rpkts = dstats->rx_packets;
 +              } while (u64_stats_fetch_retry(&dstats->syncp, start));
                stats->tx_bytes += tbytes;
                stats->tx_packets += tpkts;

Regards,
Salvatore
