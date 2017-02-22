from jinja2 import FileSystemLoader, Environment
import os


def main():
    cfiles = []
    src = ''
    obj = ''
    deps = ''
    files = os.listdir(os.getcwd())
    for file in files:
        filename, ext = os.path.splitext(file)
        if file not in cfiles and ext == '.c':
            cfiles.append(file)
    for i, file in enumerate(cfiles):
        if i < len(cfiles) - 1:
            src += '../' + filename + '.c' + ' \\\n'
            obj += './' + filename + '.o' + ' \\\n'
            deps += './' + filename + '.d' + ' \\\n'
        else:
            src += '../' + filename + '.c' + ' \n'
            obj += './' + filename + '.o' + ' \n'
            deps += './' + filename + '.d' + ' \n'
    env = Environment(loader=FileSystemLoader('/hpgcc3/templates'))
    makeT = env.get_template('subdir.tmpl')
    if not os.path.isdir('build'):
        os.mkdir('build')
    with open('build/subdir.mk', 'w') as file:
        file.write(makeT.render(sources=src, objects=obj, dependencies=deps))


if __name__ == '__main__':
    main()
