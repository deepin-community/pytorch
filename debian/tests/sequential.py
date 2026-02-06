import argparse
import torch as th

ag = argparse.ArgumentParser()
ag.add_argument('--cuda', action='store_true', help='toggle cuda mode')
ag = ag.parse_args()

print('Sequential model setup')
model = th.nn.Sequential(
        th.nn.Linear(28*28, 512),
        th.nn.ReLU(),
        th.nn.Linear(512, 128),
        th.nn.ReLU(),
        th.nn.Linear(128, 1)
        )
X = th.rand(10, 28*28)
Y = th.rand(10, 1)
if ag.cuda:
    X = X.cuda()
    Y = Y.cuda()
    model = model.cuda()
print('using device:', Y.device)
optim = th.optim.SGD(model.parameters(), lr=0.1)

loss_curve = []
for i in range(10):
    # forward
    output = model.forward(X)
    loss = th.nn.functional.mse_loss(output, Y)

    # backward
    optim.zero_grad()
    loss.backward()

    # update
    optim.step()

    loss_curve.append(loss.item())
    print('iteration', i, 'loss', loss.item())

assert(loss_curve[-1] < loss_curve[0])
print('sequential model test ok')
