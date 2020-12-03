Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D9C63777
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8DF22259
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 13:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgLCNJ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:09:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:41671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbgLCNJ2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 08:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607000876;
        bh=viEoNwWz6/XkL8f7JQsTWj8bXbAzQBOFejZsmz7qhWY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NOJtF1tD9zRqyFh7IHkl5NeowHOKGO9JwG4gr1I3Uw+QGw8t4p4tGU70z7lZ3LQGZ
         Lt3jFdQUI6lJieh4Pn7iV8grTlNbh1KyWYZDFAHAOp/51V73+Vm6KyLvKWYa/ZIfYP
         OArow7xsTOmp6xUqpkhzvvCA3adliHig88BcOUn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1kpm9Z3f2A-004xez; Thu, 03
 Dec 2020 14:07:55 +0100
Message-ID: <13b102c659c2880fcd98541a2844f0f9a028826e.camel@gmx.de>
Subject: Re: zswap explosion when using zsmalloc pool compression
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Thu, 03 Dec 2020 14:07:55 +0100
In-Reply-To: <7d4e36c78320ec01b56a12bc14ac3ddce3e26827.camel@gmx.de>
References: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
         <20201203094805.dhk3f7mlth3vm6ck@linutronix.de>
         <2b297170dbf98b36526f876650a2707e59d4ae92.camel@gmx.de>
         <7d4e36c78320ec01b56a12bc14ac3ddce3e26827.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OwthwzAYVw1UaFIQpXUjnA9YFiAgBgxeLGKwPh5slqNsyc4HmBy
 mzKnaK3bdTIYSQJU8wRY0wd0XeyrdPyH66FtgMLE95kAmbJGZI/NAvKW/09UQSQx2uQkGgQ
 cpgMafiW2nMb1XG8A/1M15j0lp9dYXou3mfOlwuIhdhZMWzuUzrFceISBa+iBzswDMiqaIg
 g8j5Agd+bzQvc3atkpb6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UbWfQBdCJ8w=:4b+WPjX2xife581CtvuITc
 yOLwSyG+aevBLdlG/7YxtbmDuVCZVYUA4laPKzc/oHHE+92dhLipdl0QqYzezNLoIqdkl4IdC
 sJCtfK0bBwhu/yxIfqMtN9rmN4fMvOTFsd9B/eX52CZ7dAQdoBJTJaRo/9SYKyYOhTXCMrhuQ
 H14TXHI/EMAw3VlmeeRXOPdBQCYfpfNGUPOxItE7ZJeXylKLzPWYNXm0VXI4Y28+58MW5G7Y5
 AVTAmRgEPHdg80VVpGFFmNtVCspRaOd9Msut9dJBnxeqie+D9hAZSM8p70oqSwSOSJSphovMd
 JI/dEh0wbk+58lxi+iIN0WdW/frCth/mHfPTO+u3yai12Lu+OxKWelt4Vm5piUjQVQFxruTBW
 5eDmcD9ZK7KqMBQcyI9RnuA7c12R+X/ww4SFDUHRjqPHEUO3p5mgmwAZ2B2uvuZduY0iNxhVp
 y/7F8Aov5rv55jPy5m0DRUaQl4p7hDe9zBu1FE7nUI2QoSBNdLpmg/TFGaqyRDWnrV8jiiWPL
 o3m7njcnKCVHcoOYWwvOdvSHhEKy3F+tTJMwafq4JrPFV5Mmmgx8cnU+1G+V12z0+j5gYtYgC
 5tKm+iNJWZbMXYupeQ0Aa+VwNLpvx7VRjz6fCwZgENtmdUEfE9/pRJx1v9p6d/D1kiqeOOK9r
 9RKSUVS9sehzAFxt+ImVg6Copmc3fHAeOWzBCwLEvzKznZAYrCPjpKQJU3ABmkucgzih4j2tW
 kfPlP/aZ7ChjgeYKvQzWB2CHPJM4RzfSJMOM1Fov5xdvxfQfQeruWfcUZXwxYbQTlWrgNcQBh
 n3UKw8zOJKqrMX/Sl0kBatPBAu+nItEGslPSa4rqt7TwiWZ89mEbCq/t1N8b5HfmLWI115t1z
 mmWk+srNcqELNOdkAucw==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-12-03 at 13:51 +0100, Mike Galbraith wrote:
>
> BUG()
> 0xffffffff812f6e90 is in zs_map_object (mm/zsmalloc.c:1401).
> 1396
> 1397            get_zspage_mapping(zspage, &class_idx, &fg);
> 1398            class =3D pool->size_class[class_idx];
> 1399            off =3D (class->size * obj_idx) & ~PAGE_MASK;
> 1400
> 1401            local_lock(&zs_map_area.lock);
> 1402            area =3D this_cpu_ptr(&zs_map_area);
> 1403            area->vm_mm =3D mm;
> 1404            if (off + class->size <=3D PAGE_SIZE) {
> 1405                    /* this object is contained entirely within a pa=
ge */


crash> rt_mutex ffff8a33ded29d20
struct rt_mutex {
  wait_lock =3D {
    raw_lock =3D {
      {
        val =3D {
          counter =3D 1
        },
        {
          locked =3D 1 '\001',
          pending =3D 0 '\000'
        },
        {
          locked_pending =3D 1,
          tail =3D 0
        }
      }
    },
    magic =3D 3735899821,
    owner_cpu =3D 4,
    owner =3D 0xffff8a337a651b40,
    dep_map =3D {
      key =3D 0x0,
      class_cache =3D {0x0, 0x0},
      name =3D 0xffffffffba10c8da "(lock).lock.lock.wait_lock",
      wait_type_outer =3D 0,
      wait_type_inner =3D 2
    }
  },
  waiters =3D {
    rb_root =3D {
      rb_node =3D 0xffffa2524328b5e0
    },
    rb_leftmost =3D 0xffffa2524328b5e0
  },
  owner =3D 0xffff8a3359ff3681,
  save_state =3D 1,
  dep_map =3D {
    key =3D 0x0,
    class_cache =3D {0x0, 0x0},
    name =3D 0x0,
    wait_type_outer =3D 0,
    wait_type_inner =3D 0
  }
}
crash>

Oh dear, lock.owner is indeed the guy who made BUG() happen.

