Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F23C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F1D61042
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhHOJC0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 15 Aug 2021 05:02:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:41377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhHOJC0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 15 Aug 2021 05:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629018102;
        bh=/emkVCszJef95728u2oytXmySDOEjKWvQTyP7NMKSvQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=A1HKfXLEFCGh7ZcsagzBgSa14D6nemb3CjI/HeVR+I3AJepmzBQlF6y2daikxD0FX
         EUaHQg8XWerklWBE3IT4XpmAkBC7jbK/DDEK+FFCkhwjfw8nZPptHir4pyhSif7cw4
         6B0dYxhjra9kPCk2XOwlc6ehzZztsaK6nTCj+yL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.48.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1mEN4t2VyP-003by3; Sun, 15
 Aug 2021 11:01:42 +0200
Message-ID: <b19fb3316eac7cef314ad16da949d5a4b19d8204.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Clark Williams <williams@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Sun, 15 Aug 2021 11:01:41 +0200
In-Reply-To: <0044f090d3919eef03048527f1baa34aec5198a8.camel@gmx.de>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
         <20210812151803.52f84aaf@theseus.lan>
         <5f0c793d-5084-4607-8475-209fa7310ba2@suse.cz>
         <20210812162448.26274298@theseus.lan>
         <bb98b54c-6d88-2a56-4998-51a304c19e8c@suse.cz>
         <20210812164440.0426d8b7@theseus.lan>
         <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
         <0044f090d3919eef03048527f1baa34aec5198a8.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Gi6hLhFM+53u78DAjGML3rJyP6bw1204G0xdyKQPl1Tlznom+c
 WM9hVdpwKSdQWgtrY7d014I+Kt/YkL+G5xYyr81zwJOKo5NRMzzGN9z3fFEw9gVC0EpLEFs
 fWDdVuIk/qM9Y4yG4oWo2bfWM0LC0EdemLRv2dEN84vMCQp9RGkmdCBfan313p51YZWrlR/
 FvxZANRoW2u8TmF21Yh7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mxUW6sOpuGs=:dBQPLZOqlp8sBr2eWgG5bg
 v2yYwAHZgDeoTMuBaxfiL/IxvGH4K9e3berqJy9Epv7t1daKTw3SQ9Dmh6RX4oE5UlVmqMkZ7
 dbkcT07wKIoNj2WuS+GF43XwcOCkR9V2ziUVCKoySJ2r+oBXOBew/snU//y2bc99YUHQeEezY
 632632KHdqvhq/P4F9HSpEruK0WEo5KhePU0xdm/PrxliSZxhwBk8HaHanoTHDOgn75Rbhhyv
 NN++1T8423ZwfJlBXtJyBz9yN16WzZ/Wz2ac5wDyr+DxgFsIzSN0l4HCjczEl50r88jRnhaBp
 u+Q2LkC6bh0JsaDSwTVEVC5T6VpJQee5Dw/Uo0hd51UWE1+pufplBMsdEUFcSTMUjMpYGqFys
 1bQ8HWA0URjkSH3qCXiM26YbWCoRMWR4/w8PMEzbp6912BatDY4e+BKAci93qIl691l26wkIQ
 dpAyH3Z0KTPuD042XcWdUSITMriVCMM9ppicswFfV8KwP+/ZM5lQSDwMCo2OrGgNmWfaaYMye
 vZzEFZYJ6kfn6jrJXHPr/jpjEpcWFXT3M0wvhJ3WBR6duRlLahSx1o8Yxe4TqV8QBi6bC4hnU
 Jn2j7denK5Z27tDXJwPomWeNGKqNhufj+TmND52LAfbYyVtKZjqKCJCW67uymGXm8MIIE5UCw
 kHsZ2JmdLC4WJ8JUpsUCNAimWDZx+dQKhA0FOF8fw4uosLaCZ6YSJDNe9pA3K0ALZ0cQCueu6
 gydNSQ+XTLZpuLeki2blS9X2gr5GX2Vj9smo3U6/Wl8urZGG/GCJOtbVi3za+7Rspk1hN8ghf
 moOdfUHVLcfg/a0zSd3I8fFABrClrtKQy2ocCk04a6dnnSwAonJDrLrzb8ZUONXP6z/RAlKwk
 oJlmG/9toaxJjrI4rWYpH+Q8byH+KsQfSJ/97zhZlJjWf4RaRqU/LDD0LbhPO5xGL8f2ogHsg
 LdQTJP2Ww5RPM6/ZdaF5HoTYHsHiF4SKGKJESK1vP2Ze5mxKZAF4yWVZZxkSzACVq3uMdz1on
 TnwOx1Ay0PsjXS7pob6R+Vd4be0smiwHKNJ9iMT3M1lvX86t6XEj4TcAahNHYZLHGYeof6/Pv
 9zXfX9hgk8Gl/a9eu6mQoM0hps2WA2O30mK
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-08-15 at 05:13 +0200, Mike Galbraith wrote:
> >
> > So hopefully the below diff with uninspired naming should help?
>
> I bet a nickle it does...

And it did.

	-Mike

