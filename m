From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH][RT] fix KM_TYPE_NR undeclared in sched.h on 32 bit x86
Date: Tue, 09 Aug 2011 10:31:29 +0200
Message-ID: <1312878690.22367.48.camel@twins>
References: <4E40B2BF.3030608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45513 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab1HIIbp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2011 04:31:45 -0400
In-Reply-To: <4E40B2BF.3030608@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-08-08 at 21:08 -0700, Darren Hart wrote:
> Patch peter_zijlstra-re-_3_0-rt4.patch causes 32 bit compilations to =
fail with:
> sched.h:1592:17: error: =E2=80=98KM_TYPE_NR=E2=80=99 undeclared here =
(not in a function)
>=20
> Including asm/kmap_types in sched.h resolves the issue.
>=20
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>

Yep indeed, I wonder why my i386-defconfig build.. header deps magic or
so.

I've updated the patch in question, thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
