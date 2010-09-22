From: Glynn Clements <glynn@gclements.plus.com>
Subject: Re: pthread_once
Date: Wed, 22 Sep 2010 21:28:06 +0100
Message-ID: <19610.26326.338860.417523@cerise.gclements.plus.com>
References: <AANLkTi=Vf3_GZHY7njqezmZNkmqvF6+NLXLc_WTmZtzU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-c-programming@vger.kernel.org, linux-rt-users@vger.kernel.org
To: ratheesh k <ratheesh.ksz@gmail.com>
Return-path: <linux-c-programming-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=Vf3_GZHY7njqezmZNkmqvF6+NLXLc_WTmZtzU@mail.gmail.com>
Sender: linux-c-programming-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


ratheesh k wrote:

> I have an embedded box running 2.6.18 linux with rt patch.
> 
> I am developing an  userspace application which need timer_create() .
> I have a big desktop machine with a 4 GB ram, running only linux
> 2.6.18 ( not rt linux ) . I would like to compile and test it on this
> Desktop PC .
> 
> I compiled my program and linked with librt.a on my Desktop PC. But
> when i run my program , it says
> 
> undefined symbol: pthread_once
> 
> what could be the problem, ???

pthread_once is defined in libpthread, which you should be linking
against if you're using librt.

-- 
Glynn Clements <glynn@gclements.plus.com>
