From: Anna-Maria Gleixner <anna-maria@glx-um.de>
Subject: Re: [patch 2/3] cyclictest: Convert the offset of the alignment  option to microseconds
Date: Sat, 30 May 2015 13:01:54 +0200
Message-ID: <47e6a4612898bdcbcf3073f27ab93708@tglx.de>
References: <20150526190333.510838769@glx-um.de>
 <20150526190443.640221319@glx-um.de>
 <alpine.LFD.2.10.1505272324180.13094@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:46514 "EHLO Tesla.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932467AbbE3LB5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 May 2015 07:01:57 -0400
In-Reply-To: <alpine.LFD.2.10.1505272324180.13094@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2015-05-27 23:32, John Kacur wrote:
> On Tue, 26 May 2015, anna-maria@glx-um.de wrote:
> Don't we need the conversion here too then?
>>  				offset = atoi(argv[optind]);

Jap, this is right. I forgot it. I changed the patch.
I forgot the same in the third patch of this series. I'll fix it and 
send the patch back to you.

	Anna-Maria


The offset is specified in microseconds according to the
documentation, but, the microseconds to nanoseconds conversion is
missing so the effective offset has the unit of nanoseconds.

Signed-off-by: Anna-Maria Gleixner <anna-maria@glx-um.de>
---
  src/cyclictest/cyclictest.c |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c
+++ rt-tests/src/cyclictest/cyclictest.c
@@ -1289,9 +1289,9 @@ static void process_options (int argc, c
  		case OPT_ALIGNED:
  			aligned=1;
  			if (optarg != NULL)
-				offset = atoi(optarg);
+				offset = atoi(optarg) * 1000;
  			else if (optind<argc && atoi(argv[optind]))
-				offset = atoi(argv[optind]);
+				offset = atoi(argv[optind]) * 1000;
  			else
  				offset = 0;
  			break;
