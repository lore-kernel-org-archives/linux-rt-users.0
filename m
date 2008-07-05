From: leon.woestenberg@gmail.com
Subject: [test - ignore] kernel patch submission script using msmtp/gmail
Date: Sat, 05 Jul 2008 05:15:25 -0700 (PDT)
Message-ID: <486f65dd.2381420a.4c1d.660a@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:13517 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYGEMPa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Jul 2008 08:15:30 -0400
Received: by ug-out-1314.google.com with SMTP id h2so892003ugf.16
        for <linux-rt-users@vger.kernel.org>; Sat, 05 Jul 2008 05:15:26 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

#!/bin/sh

# Submits a single kernel patch using GMail SMTP
# During tests, this script emails itself (nothing secret in here)

smtpemailfrom="leon.woestenberg@gmail.com"
smtpdomain=sidebranch.com
smtpserver=smtp.gmail.com
smtplogin=leon.woestenberg@gmail.com

recipients="linux-rt-users@vger.kernel.org"

patchemail=/tmp/patch.eml

echo -n "Subject: " > $patchemail
echo "[test - ignore] kernel patch submission script using msmtp/gmail" >> $patchemail
echo "" >> $patchemail

cat $0 >> $patchemail

msmtp --host=$smtpserver --auth=on --tls=on --port=587 \
--tls-certcheck=off -f $smtpemailfrom --user $smtplogin \
--maildomain $smtpdomain \
$recipients < $patchemail


