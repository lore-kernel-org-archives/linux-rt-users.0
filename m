From: John Kacur <jkacur@redhat.com>
Subject: Re: [ANNOUNCE] [REALTIME] 2.6.33.8-rt30-jk
Date: Thu, 12 Aug 2010 17:51:34 +0200
Message-ID: <AANLkTik9zZ5r9M5F6Vb4u7vnO+Bwh_jcz2v=xBw1AY8R@mail.gmail.com>
References: <AANLkTik1K3AMQhT+HA7z33A3BpE+UXPJ+a14qNT=mgz7@mail.gmail.com>
	<4C6414F3.5070403@enseirb-matmeca.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37769 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab0HLPvl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Aug 2010 11:51:41 -0400
Received: by qwh6 with SMTP id 6so1652878qwh.19
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Aug 2010 08:51:40 -0700 (PDT)
In-Reply-To: <4C6414F3.5070403@enseirb-matmeca.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 12, 2010 at 5:36 PM, Patrice Kadionik
<kadionik@enseirb-matmeca.fr> wrote:
> Le 12/08/2010 17:05, John Kacur a =E9crit :
>
> Hi John,
>
> Could you precise what brings your fork from the Thomas's mainline br=
anch?
>

It's very simple. All I did was cherry pick a bunch of stable patches
from Greg, to
create my own "stable" 2.6.33.8. Then I merged that into 2.6.33.7-rt29

Hopefully Thomas will just pick it up when he comes back from his vacat=
ion.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
