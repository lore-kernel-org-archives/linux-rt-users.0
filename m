From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests 3/3] remove license info containing an old FSF address
Date: Mon,  5 Oct 2015 21:05:17 +0200
Message-ID: <1444071917-1450-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: williams@redhat.com
To: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55415 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819AbbJETF3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 15:05:29 -0400
In-Reply-To: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The source tree contains the complete GPL so that paragraph isn't that
useful.

I didn't touch src/pi_tests/tst-mutexpi10.c (which is borrowed verbatim
from libc AFAIK) and the references containing the correct address of
the FSF.
---
 src/backfire/backfire.c               | 5 -----
 src/backfire/sendme.c                 | 5 -----
 src/pmqtest/pmqtest.c                 | 5 -----
 src/ptsematest/ptsematest.c           | 5 -----
 src/rt-migrate-test/rt-migrate-test.c | 4 ----
 src/sigwaittest/sigwaittest.c         | 5 -----
 src/svsematest/svsematest.c           | 5 -----
 7 files changed, 34 deletions(-)

diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
index aaf9c4af8e00..eb13998b8fed 100644
--- a/src/backfire/backfire.c
+++ b/src/backfire/backfire.c
@@ -12,11 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <linux/module.h>
diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index c1854d9660cb..8befffcbc722 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -12,11 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 75d5ee8185a0..bd66a6fb5106 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -12,11 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a31c745ec928..15d037d11fff 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -12,11 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index d7b68ddac3e5..72e02610cf22 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -14,10 +14,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #ifndef _GNU_SOURCE
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 91fcdaa5f185..aafce38d3d48 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -12,11 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index eeb82858720a..13e5042813c4 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -12,11 +12,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
-- 
2.1.4

