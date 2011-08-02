From: Jordi Pujol <jordipujolp@gmail.com>
Subject: Re: various tests for 3.0 rt3
Date: Tue, 2 Aug 2011 16:28:53 +0200
Message-ID: <201108021628.53845.jordipujolp@gmail.com>
References: <201107251738.51473.jordipujolp@gmail.com> <CAGQ70euqsqjxgwu_ySG=pYSMWEEC_vNvoiCQ6hFe2sPFPhCTpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	"J. R. Okajima" <hooanon05@yahoo.co.jp>
To: "Oon-Ee Ng" <ngoonee.talk@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38467 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab1HBO26 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Aug 2011 10:28:58 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so5668594fxh.19
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Aug 2011 07:28:57 -0700 (PDT)
In-Reply-To: <CAGQ70euqsqjxgwu_ySG=pYSMWEEC_vNvoiCQ6hFe2sPFPhCTpA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

A Dimarts, 2 d'agost de 2011 03:15:54, Oon-Ee Ng va escriure:
> Does anyone have a patch for this? Previously it was the nvidia
> drivers which needed to be patched, but it seems in this case the
> patch needs to be kernel-side?

making a patch is easy, license is the problem, the symbols are exported as 
GPL therefore a non-GPL module has not rights to use it,

Here is a discussion about that,

http://lwn.net/Articles/73069/

Jordi Pujol

Live never ending Tale
GNU/Linux Live forever!
http://livenet.selfip.com
