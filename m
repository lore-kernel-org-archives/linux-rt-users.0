From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Re: Changing checksums of RT patches
Date: Tue, 14 Feb 2017 00:15:33 +0100
Message-ID: <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
 <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------989DDF4B1F6F574A000FC8FC"
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:51740 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbdBMXSl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 18:18:41 -0500
In-Reply-To: <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------989DDF4B1F6F574A000FC8FC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

On 2017-02-13 23:56, Dominic Sacré wrote:
> On 2017-02-10 19:54, Sebastian Andrzej Siewior wrote:
>> Can you tell me which file in which folder changed?
> 
> The files I'm currently concerned with are in the rt/4.1/older directory.

While I was writing my previous mail, 4.1.38-rt45 was released. Attached
is a diff between rt/4.1/older/sha256sums.asc before (4 days ago) and
after -rt45 was added.
Note how the gzip-compressed files for 4.1.35-rt40 and 4.1.38-rt44
changed in the meantime.

--------------989DDF4B1F6F574A000FC8FC
Content-Type: text/x-patch;
 name="sha256sums.asc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sha256sums.asc.diff"

--- sha256sums.asc.orig	2017-02-14 00:07:29.727603816 +0100
+++ sha256sums.asc	2017-02-14 00:00:20.757619931 +0100
@@ -89,9 +89,9 @@
 840e9d8f6d310b33d0878eb9680e824a7eb0c52ac279c2eb501e30fc6e0c62d8  patch-4.1.34-rt39.patch.xz
 a4ba7d5df224d743e1f8b1422172a81dc0ff2e222809cf8820ccb934b6a7fc80  patches-4.1.34-rt39.tar.gz
 80d6ed60aeb166827c40a83f6f556def2dd0768142793947f3ea63e749863d5d  patches-4.1.34-rt39.tar.xz
-0393fcda51fc76ffa5eeb60344a0b60c96eeefe965dee1b94cdd03a0919bfc4f  patch-4.1.35-rt40.patch.gz
+cac1fc90758d942caa89cce1ba7e9e4ac6eab61bc5006d4e7641451ace345173  patch-4.1.35-rt40.patch.gz
 109032535d63aeac66cc2a76a24c98647bcb93a367a731350f6897397a55a703  patch-4.1.35-rt40.patch.xz
-b102fa127ff6650454ccf4a18544855f790959f967ad9fb56a172ab465cfabdd  patches-4.1.35-rt40.tar.gz
+a509fc7b09d2f1e196c347126be6f03ee66530baf00ae89f6a80a5f62dfa564e  patches-4.1.35-rt40.tar.gz
 9200687e7d104b48ec9326833b904708a30add9d8a8e2ade047c41f10a43a04c  patches-4.1.35-rt40.tar.xz
 284a1bc0094df0a61e6dcb9996eceea6a3791ccba1e5763e36f251d0dfeecd32  patch-4.1.35-rt41.patch.gz
 af1d65e1a9560b06599a0188a5c971ff116919473453565e2ab53dc7b1f80945  patch-4.1.35-rt41.patch.xz
@@ -105,24 +105,28 @@
 8c1a5064bcbcdd6aa0e613cf3cd0b2e3558854da5808d66b32950ebf900f034b  patch-4.1.37-rt43.patch.xz
 cf51d66c0532a002ae8d55d32bc39bc2bacea51593f32f3b4bd4830f75069b05  patches-4.1.37-rt43.tar.gz
 badde46bb4fbbeeee13a6457726a25a083da2d3b390fd8f5bcdbfd4034d87b92  patches-4.1.37-rt43.tar.xz
-646df5300a5180f7201284ab5ca20fb6ac868b64b3f780a4950ea3b5b8595a09  patch-4.1.38-rt44.patch.gz
+98730eeee49a07e555a83ae92f7eee7bb7596eb5967b121f3a9d7bf119b95c5a  patch-4.1.38-rt44.patch.gz
 14fb957835abd1ef9106561e7866ef2be94e1b02d83dd78a02d5c0d4204fed31  patch-4.1.38-rt44.patch.xz
-9f0442a699ea52b9c3364e1237181f0a746cfa56d0d761a1212036c272f069ed  patches-4.1.38-rt44.tar.gz
+fb67487ad230716a7b75d5beb8449efe0bcd9d5edbb4e59aca842ad6d38c886e  patches-4.1.38-rt44.tar.gz
 66a74b1792367806d33a7081f723cf1234c595eb8de57fadfe1456a1f238ab53  patches-4.1.38-rt44.tar.xz
+7b2e9f5ec78f508fda1f439fef08e1ee2d81e137b82cf40e62c40def781c7d41  patch-4.1.38-rt45.patch.gz
+fb2cc71641e7078509cda637f00a5964c6bd57061639919b4f1f18a07db24e4a  patch-4.1.38-rt45.patch.xz
+418268844d353bb5c7194d664440f2e89175c629bba376cda1892c9e727fae7b  patches-4.1.38-rt45.tar.gz
+67aead5194a0b1276111a47d4c76a5f6502e8cb4c852eded9d2d21876560bb85  patches-4.1.38-rt45.tar.xz
 -----BEGIN PGP SIGNATURE-----
 Version: GnuPG v1.4.12 (GNU/Linux)
 
-iQIcBAEBCAAGBQJYmzHoAAoJEGMtOgZYnaaxub0QAIUPnG0xxDuhQ/HpFwkDcLq3
-tLFO933qa6TyuR0OeVQHhLpWvtaQensZcqQ9nrrPINlmU8a4N3vBSNblaxG62GBu
-KaVI9KqPskkEw9D9pxyKDlid9wYbi57Y5bYn6s5PAFCFv3kVCfV+65jTwH2MZWMp
-oAC8Y8Jb/HWmFmy9i/6g4dS/qaJ3BdSOYRsX8QKIb1Orbne7UE8jLl2lBF/DUXgz
-tbZPUjp798MTfcg4Z1owCrSaXmUWQp0tFare87WHPTEn4TEbO7qJkbS5WHl+JpQK
-zprqeEN26kXj+MChK23RMLudbYgggdLSuf29MfufW/ESzrb/me1SDqRLmRz2jpna
-c2MkmMzT3SMf8hDujzQiiZ5oJ6Vexj1e+lkGdC3gsPSfhwwTsvJrvJxQUF7mDA1v
-CeEFNMqR3ygzvSTgz9N/CB56nL/HMK9ymZLB8Dcyhv2LyFfPezbZFZXF8jarQLV6
-Z2Rfikg+/94YACM78LKONajv+JB6mjsnIOXJ/3GV/07QrK5hBwLRXsKe843b72+x
-YyzPTsbI1gyiSHJFUolieNxnv1Bs+O+JaKTGG4MxKlDMz3/Dhxt5TMX2WjrZUtR7
-XwdZQtJo7mM34okKz8GyBib6vAgMtZyZaDg63aYs0fJGs6y+ByQnrhBK2XHoRAfZ
-003O5TS9BelNYrpL4lr6
-=iqvs
+iQIcBAEBCAAGBQJYojCAAAoJEGMtOgZYnaax+HoQAIxcyvuFvaW8ZY8EJT35CUWr
+8dtPA+Z7d/JHT4E9UIJc877tDt53G0rM6pzgPzlRy5djgyT6tfsTF6PkDNEt8g8l
+ZyxNQQ6THUYOjlrgheFYN5hu55jhYmUJ8N+/4YoXLF7Oh5ZIt3rruXDz1xPwUhX8
+IyzR+rWX3UQfjNEHf3a/tqNX59MQ3kkTrqn+gzEZionVYFfY0woe91LjNVh4z3nI
+PyY4WYVObV1HNFsmmzsyJEULX96SADuU0zTrKuRx0EJY+r9hdkW7pgI4xR8tGH0p
+2jJFaWelH2PgVsvkxPQchpS+VEh7jA5B9qXovH3ClZ4UfTqy/+Baen1qup9+tnA9
+rs4mKbL+em3A0D3P4DkAR5CTNIc0HDK6O16xuF/+NvhKqJq5mNiTZc0DiwroHEOR
+SxKo5Rz7hcJb90q3BwxJXN1yDpLctyphjxAdLnUE1y98ZvHyGLsMt9rtrYqrytI0
+5y/56Ujc2hqOxjXl872tZwRaWNnTCPvSnd+thfkvadzqGZ0+/FaN5izaR3v2ipWV
+uc+Gn8ZvP2eioV9LKN+8or8pb9mWW+JCloC/Wu+ATsKd2F6lYgrNuXVkPcZxoWD/
+LeowYbDXhowHV6BgyKP2LBaYGhE1LVMeuVKYSkJsWtWXlC7j0HBceE5jXY4zoPEp
+eN4S/hWgHpECnp71p4au
+=29uN
 -----END PGP SIGNATURE-----

--------------989DDF4B1F6F574A000FC8FC--
