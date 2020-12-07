Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6231C4361B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 02:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A910C22C7E
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 02:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgLGCUl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Dec 2020 21:20:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:33649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgLGCUl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Dec 2020 21:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607307509;
        bh=hnRNECWE//0u8EzpWhbMn8t9JZ3LNbr3JxbuZwof/yE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Bb4XqycLeWAEPpHE7KsLX1Gf4EjtMPa9DEdWXkNQUEn6Etk+oecU9bfNiqOv51tJP
         nsET10CMZxO3BIQ+sr4eGYag0dsezXenBlxaUz5D+CHhwZ+27s5RGRniu/7w3PbUM2
         hyQ9hWe7VYArCpPHDFb1yBxVrWm2iX66SRASA95U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.4]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1klHQQ0ad5-001xGx; Mon, 07
 Dec 2020 03:18:29 +0100
Message-ID: <3ffed6172820f2e8e821e1b8817dbd0bdd693c26.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Mon, 07 Dec 2020 03:18:27 +0100
In-Reply-To: <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <20201203133934.37aotbdjnd36lrxv@linutronix.de>
         <10d5088861ba219f3f7cd657fc95b0bedc19010a.camel@gmx.de>
         <cad7848c-7fd3-b4a4-c079-5896bb47ee49@konsulko.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5QE/RpeeFwD2W1T5dL+hBxZAe1Q1OtsVdTVgeILFPhAm4hPyvg
 pvFI/MCTPdNChv9N3ySM7AUNzDFOTbtqGYIou/xnoiaYuJ1X0nxc40m7eSGdaNGMnogBX9S
 +gQCAoAVD/8hjxRS/u0J3KNoIYUU4WIoVV87fIZ3TI2QXzinIN4qdhsT/N8b+W16uU6wCrN
 FxNKihYw5gci4B+abKeEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KB249BKA0nc=:5htjOMNPsDTd5vlJA6OvAO
 SV1q3DVQkI4+KjHLXDYTrZ/dGfZyb8M6ZIVjsgh1TD7XdfT0Y4tCadYLsDCQQ3eOcVSoM7Y4m
 an92NuHT/E4GCOIZ9WWQGyxlFVmKHamSL8S416DaAttE2oummQpZuVoi5SLWtpQEK8xN8z85h
 Fjgqom4cYXi7xnhjwVhLfvVhughZJWljip8JGxkHk+Av3LSchDMzjEZXHvc6gqcmvScbkvauk
 /FXdr7nAqXJcbtd5wcbijVmn/HSd8mTS0jNTjmsY7H7F39OZeNo7OZKJYATbcSCvMyIQvSd1o
 zyIl57DsFvC63yhECNVZ/Tlj0fuLCnd0yXzI1HMzqWC+aAlnzJUG5jPzsBgOQLiJoAt/Mwmo8
 0ju6T7ExqLO+Pc8L2e1UGJAj2bART5oKt52xvW2jgv+Sz+NTVX9BzZ5D039aqSx0YY05cgNGb
 SqKZgYimQ5HqP1pj1yidI13S1qdTXSajwmbiolEiXaL/54xVTccLrJw9oc6bSuthyhRUUllhY
 JBFX1UK8U181ynsfxBmh37zi0RaSyIzFJyi0d2VxqP6wpT706yT2DM63sgDekMR9lDTm5QPxw
 OLvL7YEWUK5uoRcflsRMqcpxUmnnZOEa6DoQeWzixArnZTlN+9NVZv3XwadEFES96tY5lMFqO
 zPyYVz/pGO/KpojRxtIajjlxR0jMsQIxLwiJ+NlDWkDIEjP3Bm35rLwgn7vw9Jgft+a3Dzi8c
 U2K06tvyNdC+XLRvGyVDzXx1a8WOJJwfTkrruG3VP9SkusQJWbmYZNPV6Ia6C5u1nHVPCm0yC
 ldfKmIVW2jb5Yh9hOq7rhVyrRE50+UakP3ASuYh2IEHgraZemoUxAQClWFb9bf5a01kmz4656
 rMCp22IDRaPsHL5P4VZQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-12-07 at 02:05 +0100, Vitaly Wool wrote:
>
> Could you please try the following patch in your setup:

crash> gdb list *z3fold_zpool_free+0x527
0xffffffffc0e14487 is in z3fold_zpool_free (mm/z3fold.c:341).
336                     if (slots->slot[i]) {
337                             is_free =3D false;
338                             break;
339                     }
340             }
341             write_unlock(&slots->lock);  <=3D=3D boom
342
343             if (is_free) {
344                     struct z3fold_pool *pool =3D slots_to_pool(slots);
345
crash> z3fold_buddy_slots -x ffff99a3287b8780
struct z3fold_buddy_slots {
  slot =3D {0xdeadbeef, 0xdeadbeef, 0xdeadbeef, 0xdeadbeef},
  pool =3D 0xffff99a3146b8400,
  lock =3D {
    rtmutex =3D {
      wait_lock =3D {
        raw_lock =3D {
          {
            val =3D {
              counter =3D 0x1
            },
            {
              locked =3D 0x1,
              pending =3D 0x0
            },
            {
              locked_pending =3D 0x1,
              tail =3D 0x0
            }
          }
        }
      },
      waiters =3D {
        rb_root =3D {
          rb_node =3D 0xffff99a3287b8e00
        },
        rb_leftmost =3D 0x0
      },
      owner =3D 0xffff99a355c24500,
      save_state =3D 0x1
    },
    readers =3D {
      counter =3D 0x80000000
    }
  }
}

> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 18feaa0bc537..efe9a012643d 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -544,12 +544,17 @@ static void __release_z3fold_page(struct z3fold_he=
ader *zhdr, bool locked)
>  			break;
>  		}
>  	}
> -	if (!is_free)
> +	if (!is_free) {
>  		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
> -	read_unlock(&zhdr->slots->lock);
> -
> -	if (is_free)
> +		read_unlock(&zhdr->slots->lock);
> +	} else {
> +		zhdr->slots->slot[0] =3D
> +			zhdr->slots->slot[1] =3D
> +			zhdr->slots->slot[2] =3D
> +			zhdr->slots->slot[3] =3D 0xdeadbeef;
> +		read_unlock(&zhdr->slots->lock);
>  		kmem_cache_free(pool->c_handle, zhdr->slots);
> +	}
>
>  	if (locked)
>  		z3fold_page_unlock(zhdr);

