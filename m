From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 10/15] Bluetooth: avoid recursive locking in hci_send_to_channel()
Date: Fri, 01 Dec 2017 19:01:59 -0500
Message-ID: <20171202000428.179357709@goodmis.org>
References: <20171202000149.842718953@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        stable-rt@vger.kernel.org, Mart van de Wege <mvdwege@gmail.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0010-Bluetooth-avoid-recursive-locking-in-hci_send_to_cha.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Mart reported a deadlock in -RT in the call path:
  hci_send_monitor_ctrl_event() -> hci_send_to_channel()

because both functions acquire the same read lock hci_sk_list.lock. This
is also a mainline issue because the qrwlock implementation is writer
fair (the traditional rwlock implementation is reader biased).

To avoid the deadlock there is now __hci_send_to_channel() which expects
the readlock to be held.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable-rt@vger.kernel.org
Fixes: 38ceaa00d02d ("Bluetooth: Add support for sending MGMT commands and events to monitor")
Reported-by: Mart van de Wege <mvdwege@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/bluetooth/hci_sock.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c88a6007e643..5de85b55a821 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -251,15 +251,13 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 }
 
 /* Send frame to sockets with specific channel */
-void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
-			 int flag, struct sock *skip_sk)
+static void __hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+				  int flag, struct sock *skip_sk)
 {
 	struct sock *sk;
 
 	BT_DBG("channel %u len %d", channel, skb->len);
 
-	read_lock(&hci_sk_list.lock);
-
 	sk_for_each(sk, &hci_sk_list.head) {
 		struct sk_buff *nskb;
 
@@ -285,6 +283,13 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 			kfree_skb(nskb);
 	}
 
+}
+
+void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+			 int flag, struct sock *skip_sk)
+{
+	read_lock(&hci_sk_list.lock);
+	__hci_send_to_channel(channel, skb, flag, skip_sk);
 	read_unlock(&hci_sk_list.lock);
 }
 
@@ -388,8 +393,8 @@ void hci_send_monitor_ctrl_event(struct hci_dev *hdev, u16 event,
 		hdr->index = index;
 		hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
 
-		hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
-				    HCI_SOCK_TRUSTED, NULL);
+		__hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+				      HCI_SOCK_TRUSTED, NULL);
 		kfree_skb(skb);
 	}
 
-- 
2.13.2
