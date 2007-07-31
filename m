From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 0/2][RFC] VFCIPI v3
Date: Tue, 31 Jul 2007 09:24:11 -0400
Message-ID: <20070731132153.4790.37217.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, ghaskins@novell.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:49909
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760465AbXGaNY3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 09:24:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Changelog from v2:

1) Converted "smp_call_funtion[_single]__nodelay" to
   "raw_smp_call_function[_single]" to match existing nomenclature in the -rt
   series.

2) Removed all PI related code from Patch #1 and moved it to #2 where it
   belonged.

Signed-off-by: Gregory Haskins <ghaskins@novell.com> 
